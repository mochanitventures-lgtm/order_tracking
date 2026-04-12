const express = require('express');
const router = express.Router();
const pool = require('../db');
const bcrypt = require('bcrypt');

function ensureAdmin(req, res, next) {
  if (!req.session || !req.session.user) return res.status(401).json({ error: 'Not authenticated' });
  if (req.session.user.role !== 'ADMIN') return res.status(403).json({ error: 'Admin access required' });
  return next();
}
function ensureAuth(req, res, next) {
  if (!req.session || !req.session.user) return res.redirect('/signin');
  return next();
}

router.get('/master/users', ensureAuth, (req, res) => {
  if (req.session.user.role !== 'ADMIN') return res.status(403).send('Access denied. Admin only.');
  res.render('master/users', { user: req.session.user });
});

// Alias: /api/users → /api/master/users
router.get('/api/users', ensureAdmin, async (req, res) => {
  try {
    const r = await pool.query(`
      SELECT u.user_id, u.user_name, u.user_email, u.user_phone, u.user_is_active_flag,
             u.created_at, u.updated_at, r.role_name, r.role_id
      FROM odts.users u
      LEFT JOIN odts.user_roles r ON u.user_role_id = r.role_id
      ORDER BY u.user_id`);
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

router.get('/api/master/users', ensureAdmin, async (req, res) => {
  try {
    const r = await pool.query(`
      SELECT u.user_id, u.user_name, u.user_email, u.user_phone, u.user_is_active_flag,
             u.created_at, u.updated_at, r.role_name, r.role_id
      FROM odts.users u
      LEFT JOIN odts.user_roles r ON u.user_role_id = r.role_id
      ORDER BY u.user_id`);
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

router.get('/api/master/users/roles', ensureAdmin, async (req, res) => {
  try {
    const r = await pool.query('SELECT role_id, role_name FROM odts.user_roles ORDER BY role_name');
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

router.post('/api/master/users', ensureAdmin, async (req, res) => {
  const { user_name, user_email, user_phone, role_id, user_is_active_flag, password } = req.body;
  if (!user_name || !user_email) return res.status(400).json({ error: 'Name and email are required' });
  try {
    const existing = await pool.query('SELECT user_id FROM odts.users WHERE user_email=$1', [user_email]);
    if (existing.rows.length) return res.status(400).json({ error: 'Email already exists' });
    const hash = await bcrypt.hash(password || 'Change@123', 10);
    const r = await pool.query(
      `INSERT INTO odts.users(user_name, user_email, user_phone, password_hash, user_role_id, user_is_active_flag, created_at, updated_at)
       VALUES($1,$2,$3,$4,$5,$6,now(),now()) RETURNING user_id, user_name, user_email, user_phone, user_is_active_flag, created_at`,
      [user_name.trim(), user_email.trim(), user_phone||'', hash, role_id||null, user_is_active_flag !== false]
    );
    res.status(201).json(r.rows[0]);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

router.put('/api/master/users/:id', ensureAdmin, async (req, res) => {
  const { user_name, user_email, user_phone, role_id, user_is_active_flag, password } = req.body;
  if (!user_name || !user_email) return res.status(400).json({ error: 'Name and email are required' });
  try {
    let query, params;
    if (password && password.trim()) {
      const hash = await bcrypt.hash(password, 10);
      query = `UPDATE odts.users SET user_name=$1, user_email=$2, user_phone=$3, user_role_id=$4, user_is_active_flag=$5, password_hash=$6, updated_at=now() WHERE user_id=$7 RETURNING user_id, user_name, user_email, user_phone, user_is_active_flag, updated_at`;
      params = [user_name.trim(), user_email.trim(), user_phone||'', role_id||null, user_is_active_flag !== false, hash, req.params.id];
    } else {
      query = `UPDATE odts.users SET user_name=$1, user_email=$2, user_phone=$3, user_role_id=$4, user_is_active_flag=$5, updated_at=now() WHERE user_id=$6 RETURNING user_id, user_name, user_email, user_phone, user_is_active_flag, updated_at`;
      params = [user_name.trim(), user_email.trim(), user_phone||'', role_id||null, user_is_active_flag !== false, req.params.id];
    }
    const r = await pool.query(query, params);
    if (!r.rows.length) return res.status(404).json({ error: 'User not found' });
    res.json(r.rows[0]);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

module.exports = router;
