const express = require('express');
const router = express.Router();

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

// ── In-memory mock store (replace with DB queries later) ───────────────────
let nextId = 1006;
const mockOrders = [
  {
    order_id: 1001,
    dealer_name: 'Demo Dealer',
    product_name: 'Steel Pipes',
    quantity: 50, unit: 'MT',
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

// GET /orders – render page
router.get('/orders', ensureDealer, (req, res) => {
  const role = req.session.user.role;
  const isAdmin = role === 'ADMIN' || role === 'DISPATCHER';
  res.render('orders/index', { user: req.session.user, isAdmin });
});

// GET /api/admin/orders – all orders (admin/dispatcher view)
router.get('/api/admin/orders', ensureDealer, (req, res) => {
  res.json(mockOrders);
});

// GET /api/dealer/orders – return all orders for this dealer
router.get('/api/dealer/orders', ensureDealer, (req, res) => {
  res.json(mockOrders);
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
  const { product_name, quantity, unit, delivery_location, remarks } = req.body;
  if (!product_name || !quantity || !delivery_location) {
    return res.status(400).json({ error: 'Product, quantity and delivery location are required' });
  }
  const newOrder = {
    order_id: nextId++,
    dealer_name: req.session.user.username,
    product_name,
    quantity: parseInt(quantity),
    unit: unit || 'MT',
    delivery_location,
    order_status: 'ORDER_PLACED',
    order_date: new Date().toISOString().split('T')[0],
    remarks: remarks || '',
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
  const { status } = req.body;
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
  res.json(order);
});

module.exports = router;
