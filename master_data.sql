--Idempotent Script (Re-runable)
ALTER TABLE odts.user_roles
ALTER COLUMN role_id RESTART WITH 1;
DELETE FROM odts.user_roles;
INSERT INTO odts.user_roles (role_name, role_desc) VALUES
('DEALER', 'Dealer user'),
('DISPATCHER', 'Dispatcher user'),
('OFFICE_EXECUTIVE', 'Office operations'),
('SALES_OFFICER', 'Sales team'),
('ADMIN', 'System admin')
ON CONFLICT (role_name) DO NOTHING;
SELECT * FROM user_roles;

ALTER TABLE odts.locations
ALTER COLUMN location_id RESTART WITH 1;
DELETE FROM odts.locations;
INSERT INTO odts.locations (location_name, location_desc, location_is_active_flag) VALUES
('RAKE', 'Railway rake location', TRUE),
('GODOWN', 'Storage warehouse', TRUE),
('PLANT', 'Manufacturing plant', TRUE)
ON CONFLICT (location_name) DO NOTHING;
SELECT * FROM odts.locations;

ALTER TABLE odts.dealers
ALTER COLUMN dealer_id RESTART WITH 1;
DELETE FROM odts.dealers;
INSERT INTO odts.dealers (dealer_name, dealer_code, dealer_phone, dealer_is_active_flag)
VALUES
('XYZ Enterprises', 'XYZ002', '9000000002', TRUE),
('Sharma Traders', 'SHR003', '9000000003', TRUE),
('Gupta Distributors', 'GPT004', '9000000004', TRUE),
('Verma Supplies', 'VRM005', '9000000005', TRUE),
('Agarwal Agencies', 'AGR006', '9000000006', TRUE),
('Kumar Traders', 'KMR007', '9000000007', TRUE),
('Singh Enterprises', 'SNG008', '9000000008', TRUE),
('Maheshwari Distributors', 'MSH009', '9000000009', TRUE),
('Jain Traders', 'JIN010', '9000000010', TRUE),
('Om Logistics', 'OML011', '9000000011', TRUE)
ON CONFLICT (dealer_code) DO NOTHING;
SELECT * FROM odts.dealers;

ALTER TABLE odts.users
ALTER COLUMN user_id RESTART WITH 1;
DELETE FROM odts.users;
INSERT INTO odts.users
(user_name, user_phone, user_email, password_hash, user_is_active_flag, user_role_id, dealer_id)
VALUES
(
	'ODTS Admin',
	'9999999999',
	'admin@odts.com',
	'$2b$10$d413UrdEvgjIfL3qXWxbeeBAWq5D.51uGqa6S6mjtplDNBpsa5we6',
	TRUE,
	(SELECT role_id FROM odts.user_roles WHERE role_name = 'ADMIN'),
	NULL
),
(
	'Dealer Sharma',
	'9100000003',
	'sharma@dealer.com',
	'$2b$10$cWhJZM2oH4bXBImiDO3unet.DkKgqVaANchlCeKYtn7sqJp95Vz2a',
	TRUE,
	(SELECT role_id FROM odts.user_roles WHERE role_name = 'DEALER'),
	(SELECT dealer_id FROM odts.dealers WHERE dealer_code = 'SHR003')
)
ON CONFLICT (user_phone) DO UPDATE
SET
	user_name = EXCLUDED.user_name,
	user_email = EXCLUDED.user_email,
	password_hash = EXCLUDED.password_hash,
	user_is_active_flag = EXCLUDED.user_is_active_flag,
	user_role_id = EXCLUDED.user_role_id,
	dealer_id = EXCLUDED.dealer_id;
SELECT * FROM odts.users;

ALTER TABLE odts.products
ALTER COLUMN product_id RESTART WITH 1;
DELETE FROM odts.products;
INSERT INTO odts.products (product_name, product_desc, product_is_active_flag)
VALUES
('GOLD', 'Premium grade product', TRUE),
('POWER', 'High performance product', TRUE),
('PLUS', 'Standard product', TRUE)
ON CONFLICT (product_name) DO NOTHING;
SELECT * FROM odts.products;

--dealer place an order
INSERT INTO odts.dealer_orders 
(dealer_id, product_id, source_location_id, order_quantity, order_start_date, order_status)
VALUES 
(1, 1, 1, 100, CURRENT_TIMESTAMP, 'Pending');

--order dispatched
INSERT INTO odts.order_dispatch 
(order_id, driver_id, dispatch_vehicle_number, built_number)
VALUES 
(1, 2, 'UP16AB1234', 'BLT001');
