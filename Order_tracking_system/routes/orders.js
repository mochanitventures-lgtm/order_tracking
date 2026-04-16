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
    product_name:               row.product_name,
    quantity:                   row.quantity,
    unit:                       row.unit || 'MT',
    party_name:                 row.party_name || null,
    delivery_address:           row.delivery_address || null,
    delivery_location:          row.delivery_address || null,
    contact_number:             row.contact_number || null,
    loading_type:               row.loading_type || null,
    preferred_loading_location: row.preferred_loading_location || null,
    remarks:                    row.remarks || '',
    order_status:               row.order_status,
    on_hold_by:                 row.on_hold_by || null,
    on_hold_reason:             row.on_hold_reason || null,
    order_date:                 row.order_date,
    dispatch:                   null,
  };
  if (row.dispatch_id) {
    order.dispatch = {
      dispatch_id:       row.dispatch_id,
      vehicle_no:        row.vehicle_no || null,
      driver_name:       row.driver_name || null,
      driver_phone:      row.driver_phone || null,
      dispatch_date:     row.dispatch_date || null,
      dispatch_status:   row.dispatch_status || null,
      expected_delivery: row.expected_delivery || null,
      actual_delivery:   row.actual_delivery || null,
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
           dis.dispatch_id, dis.vehicle_no, dis.driver_name, dis.driver_phone,
           dis.dispatch_date, dis.dispatch_status, dis.expected_delivery, dis.actual_delivery
    FROM odts.orders o
    LEFT JOIN odts.dealers d  ON d.dealer_id  = o.dealer_id
    LEFT JOIN odts.dispatches dis ON dis.order_id = o.order_id
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
             dis.dispatch_id, dis.vehicle_no, dis.driver_name, dis.driver_phone,
             dis.dispatch_date, dis.dispatch_status, dis.expected_delivery, dis.actual_delivery
      FROM odts.orders o
      LEFT JOIN odts.dealers d ON d.dealer_id = o.dealer_id
      INNER JOIN odts.dispatches dis ON dis.order_id = o.order_id AND dis.driver_phone = $1
    `, [phone]);
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
             dis.dispatch_id, dis.vehicle_no, dis.driver_name, dis.driver_phone,
             dis.dispatch_date, dis.dispatch_status, dis.expected_delivery, dis.actual_delivery
      FROM odts.orders o
      LEFT JOIN odts.dealers d  ON d.dealer_id  = o.dealer_id
      LEFT JOIN odts.dispatches dis ON dis.order_id = o.order_id
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
  const {
    product_name, quantity, party_name, delivery_address,
    contact_number, loading_type, preferred_loading_location,
    unit, remarks,
  } = req.body;

  if (!product_name || !quantity || !party_name || !delivery_address || !contact_number || !loading_type || !preferred_loading_location) {
    return res.status(400).json({
      error: 'Product, quantity, ship to party, delivery address, contact number, loading type and preferred loading location are required'
    });
  }

  const dealer_id = req.session.user.dealer_id;
  if (!dealer_id) return res.status(400).json({ error: 'No dealer linked to this account.' });

  try {
    const result = await pool.query(`
      INSERT INTO odts.orders
        (dealer_id, product_name, quantity, unit, party_name, delivery_address,
         contact_number, loading_type, preferred_loading_location, remarks, order_status, order_date)
      VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,'ORDER_PLACED',NOW())
      RETURNING *
    `, [
      dealer_id,
      String(product_name).trim(),
      parseInt(quantity, 10),
      unit || 'MT',
      String(party_name).trim(),
      String(delivery_address).trim(),
      String(contact_number).trim(),
      loading_type,
      preferred_loading_location,
      remarks || '',
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

    const existing = await pool.query('SELECT * FROM odts.orders WHERE order_id = $1', [parseInt(req.params.id)]);
    if (!existing.rows.length) return res.status(404).json({ error: 'Order not found' });
    const order = existing.rows[0];

    // Only dealer can reopen an order they put on hold
    if (order.order_status === 'ON_HOLD' && order.on_hold_by === 'DEALER' && requesterRole !== 'DEALER')
      return res.status(403).json({ error: 'This order was put on hold by the dealer. Only the dealer can reopen it.' });

    // Dealers can only toggle ON_HOLD ↔ ORDER_PLACED
    if (requesterRole === 'DEALER' && !['ON_HOLD', 'ORDER_PLACED'].includes(status))
      return res.status(403).json({ error: 'Dealers can only put orders on hold or reopen them.' });

    const allowed = VALID_TRANSITIONS[order.order_status] || [];
    if (!allowed.includes(status))
      return res.status(400).json({
        error: `Cannot move order from "${order.order_status}" to "${status}". Orders that are Accepted or Dispatched cannot be put On Hold.`
      });

    const resetDate = status === 'ORDER_PLACED' && requesterRole === 'DEALER';
    const on_hold_by     = status === 'ON_HOLD' ? requesterRole : null;
    const on_hold_reason = status === 'ON_HOLD' ? (reason || null) : null;

    const updated = await pool.query(`
      UPDATE odts.orders SET
        order_status   = $1,
        on_hold_by     = $2,
        on_hold_reason = $3,
        order_date     = CASE WHEN $4 THEN NOW() ELSE order_date END,
        updated_at     = NOW()
      WHERE order_id = $5
      RETURNING *
    `, [status, on_hold_by, on_hold_reason, resetDate, parseInt(req.params.id)]);

    res.json(toOrderShape({ ...updated.rows[0], dealer_name: req.session.user.username }));
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;

    delivery_location: 'Mumbai - Godown',
    order_status: 'DISPATCHED',
    order_date: '2026-03-20',
    remarks: 'Urgent requirement',
    dispatch: {
      dispatch_id: 501, dispatch_date: '2026-03-22',
      vehicle_no: 'MH-12-AB-1234', driver_name: 'Ramesh Kumar',
      driver_phone: '9876543210', dispatch_status: 'DISPATCHED',
      expected_delivery: '2026-03-25', actual_delivery: '2026-03-24'
    }
  },
  {
    order_id: 1002,
    dealer_name: 'Demo Dealer',
    product_name: 'TMT Bars',
    quantity: 100, unit: 'MT',
    delivery_location: 'Pune - Plant',
    order_status: 'DISPATCHED',
    order_date: '2026-04-01',
    remarks: '',
    dispatch: {
      dispatch_id: 502, dispatch_date: '2026-04-03',
      vehicle_no: 'MH-14-CD-5678', driver_name: 'Suresh Patil',
      driver_phone: '9123456780', dispatch_status: 'DISPATCHED',
      expected_delivery: '2026-04-07', actual_delivery: null
    }
  },
  {
    order_id: 1003,
    dealer_name: 'Demo Dealer',
    product_name: 'Wire Rods',
    quantity: 30, unit: 'MT',
    delivery_location: 'Nagpur - Rake',
    order_status: 'DISPATCHED',
    order_date: '2026-04-05',
    remarks: 'Handle with care',
    dispatch: {
      dispatch_id: 503, dispatch_date: '2026-04-06',
      vehicle_no: 'MH-40-EF-9012', driver_name: 'Vijay Sharma',
      driver_phone: '9988776655', dispatch_status: 'DISPATCHED',
      expected_delivery: '2026-04-10', actual_delivery: null
    }
  },
  {
    order_id: 1004,
    dealer_name: 'Demo Dealer',
    product_name: 'Flat Bars',
    quantity: 20, unit: 'MT',
    delivery_location: 'Mumbai - Godown',
    order_status: 'ACCEPTED',
    order_date: '2026-04-07',
    remarks: '',
    dispatch: null
  },
  {
    order_id: 1005,
    dealer_name: 'Demo Dealer',
    product_name: 'Steel Pipes',
    quantity: 75, unit: 'MT',
    delivery_location: 'Pune - Plant',
    order_status: 'ORDER_PLACED',
    order_date: '2026-04-09',
    remarks: 'New order awaiting confirmation',
    dispatch: null
  }
];

function filterOrdersByDate(orders, startDate, endDate) {
  const start = startDate ? new Date(`${startDate}T00:00:00`) : null;
  const end = endDate ? new Date(`${endDate}T23:59:59.999`) : null;

  return orders.filter((order) => {
    const orderDate = new Date(order.order_date);
    if (Number.isNaN(orderDate.getTime())) return false;
    if (start && orderDate < start) return false;
    if (end && orderDate > end) return false;
    return true;
  });
}

// GET /orders – render page
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

// GET /api/admin/orders – all orders (admin/dispatcher view)
router.get('/api/admin/orders', ensureDealer, (req, res) => {
  const { startDate, endDate } = req.query;
  res.json(filterOrdersByDate(mockOrders, startDate, endDate));
});

// GET /api/dealer/orders – return all orders for this dealer
router.get('/api/dealer/orders', ensureDealer, (req, res) => {
  const { startDate, endDate } = req.query;
  res.json(filterOrdersByDate(mockOrders, startDate, endDate));
});

// GET /api/dealer/orders/:id – single order with dispatch detail
router.get('/api/dealer/orders/:id', ensureDealer, (req, res) => {
  const order = mockOrders.find(o => o.order_id === parseInt(req.params.id));
  if (!order) return res.status(404).json({ error: 'Order not found' });
  res.json(order);
});

// GET /api/dealer/orders/by-driver/:phone – orders mapped to a driver mobile number
router.get('/api/dealer/orders/by-driver/:phone', ensureDealer, (req, res) => {
  const phone = String(req.params.phone || '').trim();
  const rows = mockOrders.filter(o => o.dispatch && o.dispatch.driver_phone === phone);
  res.json(rows);
});

// POST /api/dealer/orders – place a new order
router.post('/api/dealer/orders', ensureDealer, (req, res) => {
  const {
    product_name,
    quantity,
    party_name,
    delivery_address,
    contact_number,
    loading_type,
    preferred_loading_location,
  } = req.body;

  if (!product_name || !quantity || !party_name || !delivery_address || !contact_number || !loading_type || !preferred_loading_location) {
    return res.status(400).json({
      error: 'Product, quantity, ship to party, delivery address, contact number, loading type and preferred loading location are required'
    });
  }

  const newOrder = {
    order_id: nextId++,
    dealer_name: req.session.user.username,
    product_name,
    quantity: String(quantity).trim(),
    party_name: String(party_name).trim(),
    delivery_address: String(delivery_address).trim(),
    contact_number: String(contact_number).trim(),
    loading_type,
    preferred_loading_location,
    delivery_location: String(delivery_address).trim(),
    order_status: 'ORDER_PLACED',
    order_date: new Date().toISOString(),
    remarks: '',
    dispatch: null
  };
  mockOrders.push(newOrder);
  res.status(201).json(newOrder);
});

// Valid status transitions — accepted/dispatched cannot be put on hold
const VALID_TRANSITIONS = {
  ORDER_PLACED: ['ACCEPTED', 'ON_HOLD'],
  ACCEPTED:     ['DISPATCHED'],
  DISPATCHED:   [],
  ON_HOLD:      ['ORDER_PLACED'],
};

router.patch('/api/dealer/orders/:id/status', ensureDealer, (req, res) => {
  const order = mockOrders.find(o => o.order_id === parseInt(req.params.id));
  if (!order) return res.status(404).json({ error: 'Order not found' });
  const { status, reason } = req.body;
  const requesterRole = req.session.user.role; // 'DEALER', 'ADMIN', 'DISPATCHER'

  // If order is ON_HOLD by a dealer, only a dealer can reopen it
  if (order.order_status === 'ON_HOLD' && order.on_hold_by === 'DEALER' && requesterRole !== 'DEALER')
    return res.status(403).json({ error: 'This order was put on hold by the dealer. Only the dealer can reopen it.' });

  // Dealers can only put ORDER_PLACED → ON_HOLD or ON_HOLD → ORDER_PLACED
  if (requesterRole === 'DEALER' && !['ON_HOLD', 'ORDER_PLACED'].includes(status))
    return res.status(403).json({ error: 'Dealers can only put orders on hold or reopen them.' });

  const allowed = VALID_TRANSITIONS[order.order_status] || [];
  if (!allowed.includes(status))
    return res.status(400).json({
      error: `Cannot move order from "${order.order_status}" to "${status}". Orders that are Accepted or Dispatched cannot be put On Hold.`
    });

  order.order_status = status;
  order.on_hold_by = status === 'ON_HOLD' ? requesterRole : null;
  order.on_hold_reason = status === 'ON_HOLD' ? (reason || null) : null;

  // When a dealer releases from On Hold → Order Placed, reset the order timestamp
  if (status === 'ORDER_PLACED' && requesterRole === 'DEALER') {
    order.order_date = new Date().toISOString();
  }

  res.json(order);
});

module.exports = router;
