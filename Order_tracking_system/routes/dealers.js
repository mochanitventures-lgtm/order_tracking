const express = require('express');
const router = express.Router();
const pool = require('../db');

function ensureAdmin(req, res, next) {
  if (!req.session || !req.session.user) return res.status(401).json({ error: 'Not authenticated' });
  if (req.session.user.role !== 'ADMIN') return res.status(403).json({ error: 'Admin access required' });
  return next();
}
function ensureAuth(req, res, next) {
  if (!req.session || !req.session.user) return res.redirect('/signin');
  return next();
}

router.get('/master/dealers', ensureAuth, (req, res) => {
  if (req.session.user.role !== 'ADMIN') return res.status(403).send('Access denied. Admin only.');
  res.render('master/dealers', { user: req.session.user });
});

router.get('/api/dealers', ensureAdmin, async (req, res) => {
  try {
    const r = await pool.query(
      `SELECT dealer_id, dealer_name, dealer_code, dealer_phone, dealer_address,
              dealer_is_active_flag, created_at, updated_at
       FROM odts.dealers ORDER BY dealer_id`);
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

router.post('/api/dealers', ensureAdmin, async (req, res) => {
  const { dealer_name, dealer_code, dealer_phone, dealer_address, dealer_is_active_flag } = req.body;
  if (!dealer_name) return res.status(400).json({ error: 'Dealer name required' });
  try {
    const r = await pool.query(
      `INSERT INTO odts.dealers(dealer_name, dealer_code, dealer_phone, dealer_address, dealer_is_active_flag, created_at, updated_at)
       VALUES($1,$2,$3,$4,$5,now(),now()) RETURNING *`,
      [dealer_name.trim(), dealer_code||'', dealer_phone||'', dealer_address||'', dealer_is_active_flag !== false]
    );
    res.status(201).json(r.rows[0]);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

router.put('/api/dealers/:id', ensureAdmin, async (req, res) => {
  const { dealer_name, dealer_code, dealer_phone, dealer_address, dealer_is_active_flag } = req.body;
  if (!dealer_name) return res.status(400).json({ error: 'Dealer name required' });
  try {
    const r = await pool.query(
      `UPDATE odts.dealers SET dealer_name=$1, dealer_code=$2, dealer_phone=$3, dealer_address=$4, dealer_is_active_flag=$5, updated_at=now()
       WHERE dealer_id=$6 RETURNING *`,
      [dealer_name.trim(), dealer_code||'', dealer_phone||'', dealer_address||'', dealer_is_active_flag !== false, req.params.id]
    );
    if (!r.rows.length) return res.status(404).json({ error: 'Not found' });
    res.json(r.rows[0]);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

module.exports = router;
