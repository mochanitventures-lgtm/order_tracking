const express = require('express');
const router = express.Router();
const pool = require('../db');

const auditColCache = new Map();

async function getAuditCol(candidates) {
  const key = candidates.join('|');
  if (auditColCache.has(key)) return auditColCache.get(key);

  const r = await pool.query(
    `SELECT column_name
       FROM information_schema.columns
      WHERE table_schema = 'odts'
        AND table_name = 'user_login_audit'
        AND column_name = ANY($1::text[])
      ORDER BY array_position($1::text[], column_name)
      LIMIT 1`,
    [candidates]
  );

  const col = r.rows[0]?.column_name || null;
  auditColCache.set(key, col);
  return col;
}

function pick(col, alias, fallback = 'NULL') {
  return col ? `${col} AS ${alias}` : `${fallback} AS ${alias}`;
}

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
    const auditIdCol = await getAuditCol(['audit_id', 'login_audit_id']);
    const userIdCol = await getAuditCol(['login_user_id', 'user_id']);
    const usernameCol = await getAuditCol(['login_username', 'username']);
    const emailCol = await getAuditCol(['login_email', 'email']);
    const mobileCol = await getAuditCol(['login_mobile', 'mobile']);
    const roleCol = await getAuditCol(['login_role', 'role']);
    const methodCol = await getAuditCol(['login_method']);
    const loginAtCol = await getAuditCol(['login_at', 'created_at']);
    const ipCol = await getAuditCol(['login_ip_address', 'ip_address']);
    const userAgentCol = await getAuditCol(['login_user_agent', 'user_agent']);
    const sessionCol = await getAuditCol(['login_session_id', 'session_id']);
    const activeCol = await getAuditCol(['login_is_active', 'is_active']);
    const logoutAtCol = await getAuditCol(['logout_at', 'login_logout_at']);

    const activeWhere = activeCol
      ? `${activeCol} = TRUE`
      : (logoutAtCol ? `${logoutAtCol} IS NULL` : 'TRUE');

    const orderByCol = loginAtCol || auditIdCol || userIdCol;

    const result = await pool.query(
      `SELECT ${pick(auditIdCol, 'audit_id')},
              ${pick(userIdCol, 'user_id')},
              ${pick(usernameCol, 'username')},
              ${pick(emailCol, 'email')},
              ${pick(mobileCol, 'mobile')},
              ${pick(roleCol, 'role')},
              ${pick(methodCol, 'login_method')},
              ${pick(loginAtCol, 'login_at')},
              ${pick(ipCol, 'ip_address')},
              ${pick(userAgentCol, 'user_agent')},
              ${pick(sessionCol, 'session_id')}
         FROM odts.user_login_audit
        WHERE ${activeWhere}
        ${orderByCol ? `ORDER BY ${orderByCol} DESC` : ''}`
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

    const auditIdCol = await getAuditCol(['audit_id', 'login_audit_id']);
    const userIdCol = await getAuditCol(['login_user_id', 'user_id']);
    const usernameCol = await getAuditCol(['login_username', 'username']);
    const emailCol = await getAuditCol(['login_email', 'email']);
    const mobileCol = await getAuditCol(['login_mobile', 'mobile']);
    const roleCol = await getAuditCol(['login_role', 'role']);
    const methodCol = await getAuditCol(['login_method']);
    const statusCol = await getAuditCol(['login_status']);
    const loginAtCol = await getAuditCol(['login_at', 'created_at']);
    const logoutAtCol = await getAuditCol(['logout_at', 'login_logout_at']);
    const ipCol = await getAuditCol(['login_ip_address', 'ip_address']);
    const userAgentCol = await getAuditCol(['login_user_agent', 'user_agent']);

    const conditions = [];
    const params = [];
    let idx = 1;

    if (loginAtCol) {
      conditions.push(`${loginAtCol} >= $${idx++}::date`);
      params.push(fromDate);
      conditions.push(`${loginAtCol} < ($${idx++}::date + interval '1 day')`);
      params.push(toDate);
    }

    if (role && role !== 'ALL' && roleCol) {
      conditions.push(`${roleCol} = $${idx++}`);
      params.push(role);
    }
    if (status && status !== 'ALL' && statusCol) {
      conditions.push(`${statusCol} = $${idx++}`);
      params.push(status);
    }

    const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';
    const sessionSeconds = (loginAtCol && logoutAtCol)
      ? `CASE WHEN ${logoutAtCol} IS NOT NULL
          THEN EXTRACT(EPOCH FROM (${logoutAtCol} - ${loginAtCol}))::int
          ELSE NULL END`
      : 'NULL::int';

    const sql = `
      SELECT ${pick(auditIdCol, 'audit_id')},
             ${pick(userIdCol, 'user_id')},
             ${pick(usernameCol, 'username')},
             ${pick(emailCol, 'email')},
             ${pick(mobileCol, 'mobile')},
             ${pick(roleCol, 'role')},
             ${pick(methodCol, 'login_method')},
             ${pick(statusCol, 'login_status', `'SUCCESS'`)},
             ${pick(loginAtCol, 'login_at')},
             ${pick(logoutAtCol, 'logout_at')},
             ${pick(ipCol, 'ip_address')},
             ${pick(userAgentCol, 'user_agent')},
             ${sessionSeconds} AS session_seconds
        FROM odts.user_login_audit
       ${where}
       ${loginAtCol ? `ORDER BY ${loginAtCol} DESC` : ''}`;

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
    const roleCol = await getAuditCol(['login_role', 'role']);
    if (!roleCol) return res.json({ success: true, roles: [] });
    const result = await pool.query(
      `SELECT DISTINCT ${roleCol} AS role
         FROM odts.user_login_audit
        WHERE ${roleCol} IS NOT NULL
        ORDER BY ${roleCol}`
    );
    res.json({ success: true, roles: result.rows.map(r => r.role) });
  } catch (e) {
    res.json({ success: true, roles: [] });
  }
});

module.exports = router;
