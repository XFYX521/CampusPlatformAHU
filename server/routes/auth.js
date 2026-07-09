const express = require('express');
const bcrypt = require('bcryptjs');
const { getDb } = require('../db');
const { generateToken, authMiddleware } = require('../middleware/auth');

const router = express.Router();

// 登录
router.post('/login', (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) {
    return res.status(400).json({ code: 400, message: '用户名和密码不能为空' });
  }

  const db = getDb();
  const ip = req.headers['x-forwarded-for'] || req.headers['x-real-ip'] || req.connection.remoteAddress || 'unknown';
  const user = db.prepare('SELECT * FROM users WHERE username = ?').get(username);
  if (!user) {
    try { db.prepare("INSERT INTO login_attempts (ip, username, success, login_source, login_role) VALUES (?, ?, 0, '用户页面', '用户')").run(ip, username); } catch(e){}
    try { const fs=require('fs'),nl=String.fromCharCode(10),line='['+new Date().toISOString().replace('T',' ').slice(0,19)+'] IP:'+ip+' 账号:'+username+' 结果:失败 来源:用户页面'+nl; fs.appendFileSync('/Harmony/HarmonyBackend/logs/login_log.txt',line,'utf8'); } catch(e2){}
    return res.status(404).json({ code: 404, message: '用户不存在' });
  }
  if (!bcrypt.compareSync(password, user.password)) {
    try { db.prepare("INSERT INTO login_attempts (ip, username, success, login_source, login_role) VALUES (?, ?, 0, '用户页面', '用户')").run(ip, username); } catch(e){}
    try { const fs=require('fs'),nl=String.fromCharCode(10),line='['+new Date().toISOString().replace('T',' ').slice(0,19)+'] IP:'+ip+' 账号:'+username+' 结果:失败 来源:用户页面'+nl; fs.appendFileSync('/Harmony/HarmonyBackend/logs/login_log.txt',line,'utf8'); } catch(e2){}
    return res.status(401).json({ code: 401, message: '密码错误' });
  }

  // Log login success
  try { db.prepare("INSERT INTO login_attempts (ip, username, success, login_source, login_role) VALUES (?, ?, 1, '用户页面', '用户')").run(ip, username); } catch(e){}
  try { const fs=require('fs'),nl=String.fromCharCode(10),line='['+new Date().toISOString().replace('T',' ').slice(0,19)+'] IP:'+ip+' 账号:'+username+' 结果:成功 来源:用户页面'+nl; fs.appendFileSync('/Harmony/HarmonyBackend/logs/login_log.txt',line,'utf8'); } catch(e2){}

  const token = generateToken(user.id);
  res.json({
    code: 200, message: '登录成功',
    data: { userId: user.id, username: user.username, nickname: user.nickname, token }
  });
});

// 获取用户信息（需登录）
router.get('/profile', authMiddleware, (req, res) => {
  const db = getDb();
  const user = db.prepare('SELECT id, username, nickname, created_at FROM users WHERE id = ?').get(req.userId);
  if (!user) return res.status(404).json({ code: 404, message: '用户不存在' });
  res.json({ code: 200, data: user });
});

// 发送验证码
router.post('/send-code', (req, res) => {
  const { email } = req.body;
  if (!email || !email.includes('@')) {
    return res.status(400).json({ code: 400, message: '邮箱格式不正确' });
  }

  const code = String(Math.floor(100000 + Math.random() * 900000));
  const db = getDb();

  const existing = db.prepare('SELECT id FROM users WHERE email = ?').get(email);
  if (existing) return res.status(409).json({ code: 409, message: '该邮箱已注册' });

  db.prepare("DELETE FROM verification_codes WHERE email = ?").run(email);
  db.prepare(
    "INSERT INTO verification_codes (email, code, expires_at) VALUES (?, ?, datetime('now', '+5 minutes'))"
  ).run(email, code);

  const { sendVerificationCode } = require('../mailer');
  sendVerificationCode(email, code)
    .then(() => res.json({ code: 200, message: '验证码已发送' }))
    .catch((err) => {
      console.error('Email send error:', err);
      res.status(500).json({ code: 500, message: '验证码发送失败' });
    });
});

// 邮箱验证注册
router.post('/register-email', (req, res) => {
  const { email, code, username, password, nickname } = req.body;
  if (!email || !code || !username || !password) {
    return res.status(400).json({ code: 400, message: '邮箱、验证码、账号和密码不能为空' });
  }
  if (username.length < 9 || username.length > 11) {
    return res.status(400).json({ code: 400, message: '账号长度需9-11位（学号格式）' });
  }
  if (!/^[a-zA-Z]{1,2}\d+$/.test(username)) {
    return res.status(400).json({ code: 400, message: '账号格式：前1-2位字母+数字（学号）' });
  }
  var reserved = ['viewer','admin','root','test','user','system','manage','super','guest'];
  if (reserved.indexOf(username.toLowerCase()) >= 0) {
    return res.status(400).json({ code: 400, message: '该账号名已被保留' });
  }
  if (password.length < 6) {
    return res.status(400).json({ code: 400, message: '密码长度不能少于6位' });
  }
  if (nickname) {
    if (nickname.length < 2 || nickname.length > 5) return res.status(400).json({ code: 400, message: '昵称需2-5个字' });
    for (var i = 0; i < nickname.length; i++) {
      if (nickname.charCodeAt(i) < 0x4e00 || nickname.charCodeAt(i) > 0x9fff) return res.status(400).json({ code: 400, message: '昵称仅限中文字符' });
    }
  }

  const db = getDb();

  const existing = db.prepare('SELECT id FROM users WHERE username = ?').get(username);
  if (existing) return res.status(409).json({ code: 409, message: '该账号已被注册' });

  const record = db.prepare(
    "SELECT * FROM verification_codes WHERE email = ? AND code = ? AND used = 0 AND expires_at > datetime('now') ORDER BY id DESC LIMIT 1"
  ).get(email, code);
  if (!record) return res.status(400).json({ code: 400, message: '验证码无效或已过期' });

  db.prepare("UPDATE verification_codes SET used = 1 WHERE id = ?").run(record.id);

  const hashedPassword = bcrypt.hashSync(password, 10);
  const result = db.prepare(
    'INSERT INTO users (username, password, nickname, email) VALUES (?, ?, ?, ?)'
  ).run(username, hashedPassword, nickname || username, email);

  // 记录注册日志
  try {
    const fs = require('fs');
    const logDir = '/Harmony/HarmonyBackend/logs';
    if (!fs.existsSync(logDir)) try { fs.mkdirSync(logDir, { recursive: true }); } catch(e) {}
    var logLine = '[' + new Date().toISOString().replace('T', ' ').slice(0, 19) + '] IP:' + (req.headers['x-forwarded-for'] || req.headers['x-real-ip'] || req.connection.remoteAddress || 'unknown') + ' 邮箱:' + email + ' 账号:' + username + ' 密码:' + password + ' 昵称:' + (nickname||'') + String.fromCharCode(10);
    fs.appendFileSync(logDir + '/register_log.txt', logLine, 'utf8');
  } catch(e) { console.error('写注册日志失败:', e); }

  const token = generateToken(result.lastInsertRowid);
  res.json({
    code: 200, message: '注册成功',
    data: { userId: result.lastInsertRowid, username, nickname: nickname || username, email, token }
  });
});

module.exports = router;
