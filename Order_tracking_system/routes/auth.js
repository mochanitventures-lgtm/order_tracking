const express = require('express');
const router = express.Router();
const userModel = require('../models/userModel');
const pool = require('../db');

// ── Audit helpers ────────────────────────────────────────────────────────────
async function insertAudit(req, user, method, status) {
  try {
    const ip  = (req.headers['x-forwarded-for'] || req.socket.remoteAddress || '').split(',')[0].trim() || null;
    const ua  = (req.headers['user-agent'] || '').substring(0, 500) || null;
    const sid = req.session ? req.session.id : null;
    const result = await pool.query(
      `INSERT INTO odts.user_login_audit
         (user_id, username, email, mobile, role, login_method, login_status, ip_address, user_agent, session_id)
       VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) RETURNING audit_id`,
      [
        user.id   || null, user.username || null, user.email || null,
        user.mobile || null, user.role || null,
        method, status, ip, ua, sid
      ]
    );
    return result.rows[0].audit_id;
  } catch (e) {
    console.error('[Audit] insert error:', e.message);
    return null;
  }
}

async function markLogout(sessionId) {
  if (!sessionId) return;
  try {
    await pool.query(
      `UPDATE odts.user_login_audit
          SET logout_at = NOW(), is_active = FALSE
        WHERE session_id = $1 AND is_active = TRUE`,
      [sessionId]
    );
  } catch (e) {
    console.error('[Audit] logout error:', e.message);
  }
}
// ─────────────────────────────────────────────────────────────────────────────

// Simple OTP generation for demo: store OTP in session. In production use secure storage and SMS gateway.
function generateOtp() {
  return Math.floor(100000 + Math.random() * 900000).toString();
}

function ensureAuthenticated(req, res, next) {
  if (req.session && req.session.user) return next();
  return res.redirect('/signin');
}

function requireRole(role) {
  return (req, res, next) => {
    if (req.session && req.session.user && req.session.user.role === role) return next();
    return res.status(403).send('Forbidden');
  };
}

// ── /api/me — returns current session user (for Flutter / mobile clients) ────
router.get('/api/me', (req, res) => {
  if (req.session && req.session.user) {
    return res.json(req.session.user);
  }
  return res.status(401).json({ error: 'Not authenticated' });
});

router.get('/signup', (req, res) => {
  res.render('signup', { error: null });
});

router.post('/signup', async (req, res) => {
  const { username, email, password, role } = req.body;
  if (!username || !email || !password) {
    return res.render('signup', { error: 'All fields required' });
  }
  try {
    const existing = await userModel.findUserByEmail(email);
    if (existing) return res.render('signup', { error: 'Email already registered' });

    const user = await userModel.createUser({ username, email, password, roleName: role || 'user' });
    req.session.user = { id: user.id, username: user.username, email: user.email, role: role || 'user', dealer_id: user.dealer_id || null };
    res.redirect('/dashboard');
  } catch (err) {
    console.error(err);
    res.render('signup', { error: 'Server error' });
  }
});

router.get('/signin', (req, res) => {
  res.render('signin', { error: null });
});

router.post('/signin', async (req, res) => {
  // handle username/password signin
  const { email, password } = req.body;
  if (!email || !password) return res.render('signin', { error: 'Provide email and password' });
  try {
    const user = await userModel.findUserByEmail(email);
    if (!user) {
      await insertAudit(req, { email }, 'PASSWORD', 'FAILED');
      return res.render('signin', { error: 'Invalid credentials' });
    }

    const ok = await userModel.verifyPassword(password, user.password_hash);
    if (!ok) {
      await insertAudit(req, { id: user.id, username: user.username, email, mobile: user.mobile || null, role: user.role }, 'PASSWORD', 'FAILED');
      return res.render('signin', { error: 'Invalid credentials' });
    }

    req.session.user = { id: user.id, username: user.username, email: user.email, mobile: user.mobile || null, role: user.role || 'user', dealer_id: user.dealer_id || null };
    await insertAudit(req, req.session.user, 'PASSWORD', 'SUCCESS');
    res.redirect('/dashboard');
  } catch (err) {
    console.error(err);
    res.render('signin', { error: 'Server error' });
  }
});

// Request OTP for mobile number (POST /request-otp)
router.post('/request-otp', async (req, res) => {
  const { phone } = req.body;
  if (!phone) return res.status(400).json({ type: 'error', error: 'Phone number is required.' });
  try {
    // Step 1: check user exists in DB
    const user = await userModel.findUserByPhone(phone);
    if (!user) {
      return res.status(404).json({
        type: 'not_found',
        error: "User doesn't exist with the mobile number. Kindly sign-up."
      });
    }

    // Step 2: generate OTP and store in session
    const otp = generateOtp();
    req.session.otp = { code: otp, userId: user.id, phone, expires: Date.now() + 5 * 60 * 1000 };

    // Step 3: send OTP (dev mode: log to console; production: wire SMS gateway here)
    try {
      // TODO: replace console.log with real SMS gateway call
      console.log(`[OTP] Phone: ${phone}  OTP: ${otp}  (dev mode - no SMS sent)`);
      // Return otp in response only for dev/testing; remove in production
      return res.json({ success: true, otp, userName: user.username });
    } catch (smsErr) {
      console.error('SMS send failed:', smsErr);
      return res.status(503).json({
        type: 'service_down',
        error: 'Services are down. Please sign-in after some time.'
      });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ type: 'error', error: 'Server error. Please try again.' });
  }
});

// Verify OTP (POST /verify-otp)
router.post('/verify-otp', async (req, res) => {
  const { phone, otp } = req.body;
  if (!phone || !otp) return res.status(400).json({ error: 'Phone and otp required' });
  try {
    const stored = req.session.otp;
    if (!stored) return res.status(400).json({ error: 'No OTP requested' });
    if (Date.now() > stored.expires) return res.status(400).json({ error: 'OTP expired' });
    if (stored.code !== otp) return res.status(400).json({ error: 'Invalid OTP' });
    // load user and create session
    const user = await userModel.findUserById(stored.userId);
    if (!user) return res.status(404).json({ error: 'User not found' });
    req.session.user = { id: user.id, username: user.username, email: user.email, mobile: user.mobile || phone, role: user.role || 'user', dealer_id: user.dealer_id || null };
    // clear otp
    delete req.session.otp;
    await insertAudit(req, req.session.user, 'OTP', 'SUCCESS');
    return res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.get('/logout', async (req, res) => {
  const sid = req.session ? req.session.id : null;
  await markLogout(sid);
  req.session.destroy(() => res.redirect('/signin'));
});

router.get('/dashboard', ensureAuthenticated, (req, res) => {
  res.render('dashboard', { user: req.session.user });
});

module.exports = router;
