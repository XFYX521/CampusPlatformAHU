const path = require('path');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

const ADMINS = {
  "example": { password: "example", role: "super", name: "超级管理员" }//这里是网页后的登录账号与密码，请在使用前修改
};
const ADMIN_SECRET = "harmony_admin_secret_2024";

function getClientIp(req) {
  return req.headers['x-forwarded-for'] || req.headers['x-real-ip'] || req.connection.remoteAddress || 'unknown';
}

function authToken(req) {
  const token = req.query.token || (req.headers.authorization || '').replace('Bearer ', '');
  if (!token) return null;
  try { return jwt.verify(token, ADMIN_SECRET); }
  catch { return null; }
}

function requireSuper(req, res, next) {
  const decoded = authToken(req);
  if (!decoded) return res.status(401).json({ code: 401, message: '未登录' });
  if (decoded.role !== 'super') return res.status(403).json({ code: 403, message: '权限不足' });
  req.admin = decoded;
  next();
}

function setupAdminPage(app, db) {
  // 登录页
  app.get('/admin/login', (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'public', 'login.html'));
  });

  // 登录接口
  app.post('/api/admin/login', (req, res) => {
    const { username, password } = req.body;
    const ip = getClientIp(req);
    const admin = ADMINS[username];
    if (admin && password === admin.password) {
      const token = jwt.sign({ role: admin.role, name: admin.name, username }, ADMIN_SECRET, { expiresIn: '24h' });
      try { db.prepare("INSERT INTO login_attempts (ip, username, success, login_source, login_role) VALUES (?, ?, 1, '后台', ?)").run(ip, username, admin.role); } catch(e){}
      try { const fs=require('fs'),nl=String.fromCharCode(10),line='['+new Date().toISOString().replace('T',' ').slice(0,19)+'] IP:'+ip+' 账号:'+username+' 结果:成功 来源:后台 角色:'+admin.role+nl; fs.appendFileSync('/Harmony/HarmonyBackend/logs/login_log.txt',line,'utf8'); } catch(e2){}
      return res.json({ code: 200, message: '登录成功', data: { token, role: admin.role, name: admin.name } });
    }
    try { db.prepare("INSERT INTO login_attempts (ip, username, success, login_source) VALUES (?, ?, 0, '后台')").run(ip, username); } catch(e){}
    try { const fs=require('fs'),nl=String.fromCharCode(10),line='['+new Date().toISOString().replace('T',' ').slice(0,19)+'] IP:'+ip+' 账号:'+username+' 结果:失败 来源:后台'+nl; fs.appendFileSync('/Harmony/HarmonyBackend/logs/login_log.txt',line,'utf8'); } catch(e2){}
    res.status(401).json({ code: 401, message: '账号或密码错误' });
  });

  // 后台首页
  app.get('/admin', (req, res) => {
    const decoded = authToken(req);
    if (!decoded) return res.redirect('/admin/login');
    res.sendFile(path.join(__dirname, '..', 'public', 'admin.html'));
  });

  // 当前用户信息
  app.get('/api/admin/me', (req, res) => {
    const decoded = authToken(req);
    if (!decoded) return res.status(401).json({ code: 401, message: '未登录' });
    res.json({ code: 200, data: { role: decoded.role, name: decoded.name, username: decoded.username } });
  });

  // 用户列表（viewer可看）
  app.get('/api/admin/users', (req, res) => {
    const decoded = authToken(req);
    if (!decoded) return res.status(401).json({ code: 401, message: '未登录' });
    const users = db.prepare('SELECT id, username, nickname, created_at FROM users ORDER BY id DESC').all();
    res.json({ code: 200, data: users });
  });

  // 单个用户（viewer可看）
  app.get('/api/admin/users/:id', (req, res) => {
    const decoded = authToken(req);
    if (!decoded) return res.status(401).json({ code: 401, message: '未登录' });
    const user = db.prepare('SELECT id, username, nickname, created_at FROM users WHERE id = ?').get(req.params.id);
    if (!user) return res.status(404).json({ code: 404, message: '用户不存在' });
    res.json({ code: 200, data: user });
  });

  // 编辑用户
  app.put('/api/admin/users/:id', requireSuper, (req, res) => {
    const { nickname, password } = req.body;
    const user = db.prepare('SELECT * FROM users WHERE id = ?').get(req.params.id);
    if (!user) return res.status(404).json({ code: 404, message: '用户不存在' });
    let newNick = nickname !== undefined ? nickname : user.nickname;
    if (password) {
      const hashed = bcrypt.hashSync(password, 10);
      db.prepare('UPDATE users SET nickname = ?, password = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?').run(newNick, hashed, req.params.id);
    } else {
      db.prepare('UPDATE users SET nickname = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?').run(newNick, req.params.id);
    }
    res.json({ code: 200, message: '更新成功' });
  });

  // 删除用户
  app.delete('/api/admin/users/:id', requireSuper, (req, res) => {
    const user = db.prepare('SELECT id FROM users WHERE id = ?').get(req.params.id);
    if (!user) return res.status(404).json({ code: 404, message: '用户不存在' });
    db.prepare('DELETE FROM users WHERE id = ?').run(req.params.id);
    res.json({ code: 200, message: '已删除' });
  });

  // 站点导航
  app.get('/nav', requireSuper, (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'public', 'nav.html'));
  });

  // 接口文档
  app.get('/api-docs', requireSuper, (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'public', 'api-docs.html'));
  });

  // 登录日志
  app.get('/api/admin/loginlog', requireSuper, (req, res) => {
    const rows = db.prepare("SELECT ip, username, attempt_time, success, login_source, login_role FROM login_attempts ORDER BY attempt_time DESC LIMIT 100").all();
    res.json({ code: 200, data: rows });
  });

  // 反馈列表
  app.get('/api/admin/feedbacks', requireSuper, (req, res) => {
    const rows = db.prepare("SELECT id, user_id, username, nickname, title, content, created_at FROM feedbacks ORDER BY id DESC LIMIT 100").all();
    res.json({ code: 200, data: rows });
  });

  // 注册日志
  app.get('/api/admin/reglog', requireSuper, (req, res) => {
    try {
      const fs = require('fs');
      const logFile = '/Harmony/HarmonyBackend/logs/register_log.txt';
      if (!fs.existsSync(logFile)) return res.json({ code: 200, data: [] });
      var lines = fs.readFileSync(logFile, 'utf8').split(String.fromCharCode(10)).filter(Boolean).reverse().slice(0, 100);
      lines = lines.map(function(l) {
        return l.replace(/^\[(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\]/, function(m, t) {
          var d = new Date(t.replace(' ', 'T') + 'Z');
          d.setHours(d.getHours() + 8);
          return '[' + d.toISOString().replace('T', ' ').slice(0, 19) + ']';
        });
      });
      res.json({ code: 200, data: lines });
    } catch(e) {
      res.json({ code: 200, data: [] });
    }
  });
}

module.exports = { setupAdminPage };
