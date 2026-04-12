const db = require('../db');
const bcrypt = require('bcrypt');

const SALT_ROUNDS = 10;

// The database uses `odts` schema with different column names; map them to our app's expected fields
async function findUserByEmail(email) {
  const res = await db.query(
    `SELECT u.user_id as id, u.user_name as username, u.user_email as email, u.password_hash, r.role_name as role, u.user_role_id as role_id
     FROM odts.users u LEFT JOIN odts.user_roles r ON u.user_role_id = r.role_id WHERE u.user_email = $1`,
    [email]
  );
  return res.rows[0];
}

async function findUserById(id) {
  const res = await db.query(
    `SELECT u.user_id as id, u.user_name as username, u.user_email as email, r.role_name as role, u.user_role_id as role_id
     FROM odts.users u LEFT JOIN odts.user_roles r ON u.user_role_id = r.role_id WHERE u.user_id = $1`,
    [id]
  );
  return res.rows[0];
}

async function findUserByPhone(phone) {
  const res = await db.query(
    `SELECT u.user_id as id, u.user_name as username, u.user_email as email, u.user_phone as phone, u.password_hash, r.role_name as role, u.user_role_id as role_id
     FROM odts.users u LEFT JOIN odts.user_roles r ON u.user_role_id = r.role_id WHERE u.user_phone = $1`,
    [phone]
  );
  return res.rows[0];
}

async function createUser({ username, email, password, roleName = 'DEALER' }) {
  const hash = await bcrypt.hash(password, SALT_ROUNDS);

  // Find role id in odts.user_roles
  const roleRes = await db.query('SELECT role_id FROM odts.user_roles WHERE role_name = $1', [roleName]);
  let roleId;
  if (roleRes.rows.length) {
    roleId = roleRes.rows[0].role_id;
  } else {
    // fallback: insert role_name
    const insertRole = await db.query('INSERT INTO odts.user_roles(role_name) VALUES($1) RETURNING role_id', [roleName]);
    roleId = insertRole.rows[0].role_id;
  }

  // Insert minimal required fields into odts.users; some fields may be NULL depending on schema
  const insert = await db.query(
    `INSERT INTO odts.users(user_name, user_email, password_hash, user_role_id, user_is_active_flag, created_at)
     VALUES($1, $2, $3, $4, true, now()) RETURNING user_id as id, user_name as username, user_email as email`,
    [username, email, hash, roleId]
  );
  return insert.rows[0];
}

async function verifyPassword(plain, hash) {
  return bcrypt.compare(plain, hash);
}

module.exports = {
  findUserByEmail,
  findUserById,
  findUserByPhone,
  createUser,
  verifyPassword
};

