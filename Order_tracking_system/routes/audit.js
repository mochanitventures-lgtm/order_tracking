const express = require('express');
const router = express.Router();
const pool = require('../db');

function ensureAdmin(req, res, next) {
  if (req.session && req.session.user && req.session.user.role === 'ADMIN') return next();
  return res.status(403).send('Forbidden – Admin only');
}

// ── Page ──────────────────────────────────────────────────────────────────────
router.get('/admin/sessions', ensureAdmin, (req, res) => {
  res.render('admin/sessions', { user: req.session.user });
});

// ── API: currently active sessions ───────────────────────────────────────────
router.get('/api/admin/active-sessions', ensureAdmin, async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT audit_id, user_id, username, email, mobile, role,
              login_method, login_at, ip_address, user_agent, session_id
         FROM odts.user_login_audit
        WHERE is_active = TRUE
        ORDER BY login_at DESC`
    );
    res.json({ success: true, rows: result.rows });
  } catch (e) {
    console.error('[Audit API] active-sessions error:', e.message);
    res.status(500).json({ success: false, error: e.message });
  }
});

// ── API: login history report (date range + optional role filter) ─────────────
router.get('/api/admin/login-report', ensureAdmin, async (req, res) => {
  try {
    const { from, to, role, status } = req.query;
    // default: today
    const fromDate = from || new Date().toISOString().slice(0, 10);
    const toDate   = to   || new Date().toISOString().slice(0, 10);

    const conditions = [`login_at >= $1::date`, `login_at < ($2::date + interval '1 day')`];
    const params = [fromDate, toDate];
    let idx = 3;

    if (role && role !== 'ALL') {
      conditions.push(`role = $${idx++}`);
      params.push(role);
    }
    if (status && status !== 'ALL') {
      conditions.push(`login_status = $${idx++}`);
      params.push(status);
    }

    const sql = `
      SELECT audit_id, user_id, username, email, mobile, role,
             login_method, login_status, login_at, logout_at,
             ip_address, user_agent,
             CASE WHEN logout_at IS NOT NULL
               THEN EXTRACT(EPOCH FROM (logout_at - login_at))::int
               ELSE NULL END AS session_seconds
        FROM odts.user_login_audit
       WHERE ${conditions.join(' AND ')}
       ORDER BY login_at DESC`;

    const result = await pool.query(sql, params);
    res.json({ success: true, rows: result.rows });
  } catch (e) {
    console.error('[Audit API] login-report error:', e.message);
    res.status(500).json({ success: false, error: e.message });
  }
});

// ── API: available roles for filter dropdown ──────────────────────────────────
router.get('/api/admin/audit-roles', ensureAdmin, async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT DISTINCT role FROM odts.user_login_audit WHERE role IS NOT NULL ORDER BY role`
    );
    res.json({ success: true, roles: result.rows.map(r => r.role) });
  } catch (e) {
    res.json({ success: true, roles: [] });
  }
});

module.exports = router;
