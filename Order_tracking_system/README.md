# Order Tracking Management System (Auth Prototype)

Quick starter app with signup/signin and role-based login using PostgreSQL.

Prerequisites
- Node 18+ / npm
- PostgreSQL running locally on port 5432

DB connection (already configured):
- host: localhost
- port: 5432
- user: odts_admin
- password: admin123

Database schema (run once):

```sql
CREATE TABLE IF NOT EXISTS user_roles (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(150) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role_id INT REFERENCES user_roles(id),
  created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now()
);

-- Seed a default role
INSERT INTO user_roles(name) VALUES('user') ON CONFLICT (name) DO NOTHING;
INSERT INTO user_roles(name) VALUES('admin') ON CONFLICT (name) DO NOTHING;
```

Install & run

```bash
cd /Users/ajitverma/Documents/Order_tracking_system
npm install
npm run dev   # requires nodemon (dev dependency)
# or
npm start
```

Files added
- server.js - main express server
- db.js - PG connection
- models/userModel.js - simple user model
- routes/auth.js - signup/signin/logout/dashboard
- views/*.ejs - EJS templates (Bootstrap)
- public/css/style.css - small styling

Notes
- This is a minimal starter; for production use, secure session secret, use HTTPS, store sessions persistently, validate inputs, and handle errors robustly.
