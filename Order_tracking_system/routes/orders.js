const express = require('express');
const router = express.Router();
const pool = require('../db');

function ensureAuth(req, res, next) {
  if (!req.session || !req.session.user) return res.redirect('/signin');
  return next();
}
function ensureDealer(req, res, next) {
  if (!req.session || !req.session.user) return res.redirect('/signin');
  const role = req.session.user.role;
  if (role !== 'DEALER' && role !== 'ADMIN' && role !== 'DISPATCHER') return res.status(403).send('Access denied.');
  return next();
}

// Valid status transitions
const VALID_TRANSITIONS = {
  ORDER_PLACED: ['ACCEPTED', 'ON_HOLD'],
  ACCEPTED:     ['DISPATCHED'],
  DISPATCHED:   [],
  ON_HOLD:      ['ORDER_PLACED'],
};

// Shape a DB row into the object the frontend expects
function toOrderShape(row) {
  const order = {
    order_id:                   row.order_id,
    dealer_id:                  row.dealer_id,
    dealer_name:                row.dealer_name || null,
    product_name:               row.product_name || row.product_id,
    quantity:                   row.order_quantity,
    unit:                       'MT',
    party_name:                 null,
    delivery_address:           null,
    delivery_location:          null,
    contact_number:             null,
    loading_type:               null,
    preferred_loading_location: null,
    remarks:                    '',
    order_status:               row.order_status,
    on_hold_by:                 null,
    on_hold_reason:             null,
    order_date:                 row.order_date,
    dispatch:                   null,
  };
  if (row.dispatch_id) {
    order.dispatch = {
      dispatch_id:       row.dispatch_id,
      vehicle_no:        row.dispatch_vehicle_number || null,
      driver_name:       row.driver_name || null,
      driver_phone:      row.driver_phone || null,
      dispatch_date:     row.created_at || null,
      dispatch_status:   null,
      expected_delivery: null,
      actual_delivery:   null,
    };
  }
  return order;
}

// Fetch orders with optional dealer + date filters
async function fetchOrders({ dealerId, startDate, endDate }) {
  const conditions = [];
  const values = [];
  let i = 1;
  if (dealerId) {
    conditions.push(`o.dealer_id = $${i++}`);
    values.push(dealerId);
  }
  if (startDate) {
    conditions.push(`o.order_date >= $${i++}`);
    values.push(`${startDate}T00:00:00`);
  }
  if (endDate) {
    conditions.push(`o.order_date <= $${i++}`);
    values.push(`${endDate}T23:59:59.999`);
  }
  const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';
  const sql = `
    SELECT o.*,
           d.dealer_name,
           od.dispatch_id, od.dispatch_vehicle_number, od.driver_id, od.created_at
    FROM odts.dealer_orders o
    LEFT JOIN odts.dealers d  ON d.dealer_id  = o.dealer_id
    LEFT JOIN odts.order_dispatch od ON od.order_id = o.order_id
    ${where}
    ORDER BY o.order_date DESC
  `;
  const result = await pool.query(sql, values);
  return result.rows.map(toOrderShape);
}

// ── Page routes ───────────────────────────────────────────────────────────────

router.get('/orders', ensureDealer, (req, res) => {
  const role = req.session.user.role;
  const isAdmin = role === 'ADMIN' || role === 'DISPATCHER';
  if (!isAdmin && req.query.action === 'new') {
    return res.render('orders/new', { user: req.session.user });
  }
  res.render('orders/index', { user: req.session.user, isAdmin });
});

router.get('/orders/new', ensureDealer, (req, res) => {
  if (req.session.user.role !== 'DEALER') return res.redirect('/orders');
  res.render('orders/new', { user: req.session.user });
});

// ── API routes ────────────────────────────────────────────────────────────────

// GET /api/admin/orders – all orders (admin/dispatcher)
router.get('/api/admin/orders', ensureDealer, async (req, res) => {
  try {
    const { startDate, endDate } = req.query;
    res.json(await fetchOrders({ startDate, endDate }));
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
});

// GET /api/dealer/orders – orders for the logged-in dealer
router.get('/api/dealer/orders', ensureDealer, async (req, res) => {
  try {
    const { startDate, endDate } = req.query;
    const role = req.session.user.role;
    const dealerId = role === 'DEALER' ? req.session.user.dealer_id : null;
    res.json(await fetchOrders({ dealerId, startDate, endDate }));
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
});

// GET /api/dealer/orders/by-driver/:phone
router.get('/api/dealer/orders/by-driver/:phone', ensureDealer, async (req, res) => {
  try {
    const phone = String(req.params.phone || '').trim();
    const result = await pool.query(`
      SELECT o.*, d.dealer_name,
             od.dispatch_id, od.dispatch_vehicle_number, od.driver_id, od.created_at
      FROM odts.dealer_orders o
      LEFT JOIN odts.dealers d ON d.dealer_id = o.dealer_id
      INNER JOIN odts.order_dispatch od ON od.order_id = o.order_id
      WHERE od.driver_id IS NOT NULL
    `, []);
    res.json(result.rows.map(toOrderShape));
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
});

// GET /api/dealer/orders/:id – single order
router.get('/api/dealer/orders/:id', ensureDealer, async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT o.*, d.dealer_name,
             od.dispatch_id, od.dispatch_vehicle_number, od.driver_id, od.created_at
      FROM odts.dealer_orders o
      LEFT JOIN odts.dealers d  ON d.dealer_id  = o.dealer_id
      LEFT JOIN odts.order_dispatch od ON od.order_id = o.order_id
      WHERE o.order_id = $1
    `, [parseInt(req.params.id)]);
    if (!result.rows.length) return res.status(404).json({ error: 'Order not found' });
    res.json(toOrderShape(result.rows[0]));
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
});

// POST /api/dealer/orders – place a new order
router.post('/api/dealer/orders', ensureDealer, async (req, res) => {
  const { product_id, quantity } = req.body;

  if (!product_id || !quantity) {
    return res.status(400).json({
      error: 'Product ID and quantity are required'
    });
  }

  const dealer_id = req.session.user.dealer_id;
  if (!dealer_id) return res.status(400).json({ error: 'No dealer linked to this account.' });

  try {
    const result = await pool.query(`
      INSERT INTO odts.dealer_orders
        (dealer_id, product_id, order_quantity, order_status, order_date, created_by, created_at)
      VALUES ($1, $2, $3, 'ORDER_PLACED', NOW(), $4, NOW())
      RETURNING *
    `, [
      dealer_id,
      parseInt(product_id, 10),
      parseInt(quantity, 10),
      req.session.user.user_id,
    ]);
    res.status(201).json(toOrderShape({ ...result.rows[0], dealer_name: req.session.user.username }));
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
});

// PATCH /api/dealer/orders/:id/status
router.patch('/api/dealer/orders/:id/status', ensureDealer, async (req, res) => {
  try {
    const { status, reason } = req.body;
    const requesterRole = req.session.user.role;

    const existing = await pool.query('SELECT * FROM odts.dealer_orders WHERE order_id = $1', [parseInt(req.params.id)]);
    if (!existing.rows.length) return res.status(404).json({ error: 'Order not found' });
    const order = existing.rows[0];

    const allowed = VALID_TRANSITIONS[order.order_status] || [];
    if (!allowed.includes(status))
      return res.status(400).json({
        error: `Cannot move order from "${order.order_status}" to "${status}".`
      });

    const updated = await pool.query(`
      UPDATE odts.dealer_orders SET
        order_status = $1,
        updated_at   = NOW()
      WHERE order_id = $2
      RETURNING *
    `, [status, parseInt(req.params.id)]);

    res.json(toOrderShape({ ...updated.rows[0], dealer_name: req.session.user.username }));
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
