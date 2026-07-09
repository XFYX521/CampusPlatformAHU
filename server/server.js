const express = require('express');
const path = require('path');
const cors = require('cors');
const helmet = require('helmet');
const { setupAdminPage } = require('./routes/admin');
const authRoutes = require('./routes/auth');
const { getDb } = require('./db');

const app = express();
const PORT = example;

app.use(helmet({ contentSecurityPolicy: false, hsts: false }));
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Root → 登录页
app.get('/', (req, res) => {
  res.redirect('/admin/login');
});

// Health
app.get('/api/health', (req, res) => {
  res.json({ code: 200, message: '鸿蒙后端 is running', time: new Date().toISOString() });
});

// 隐私政策（需token）
const DOC_TOKEN = 'harmong_doc_sk_2024';
const DOC_DIR = path.join(__dirname, 'doucuments');

function readDoc(filename) {
  try {
    const fs = require('fs');
    const fp = path.join(DOC_DIR, filename);
    if (!fs.existsSync(fp)) return null;
    return fs.readFileSync(fp, 'utf8');
  } catch(e) { return null; }
}

app.get('/api/privacy', (req, res) => {
  const token = req.query.token || req.headers['x-doc-token'];
  if (token !== DOC_TOKEN) return res.status(403).json({ code: 403, message: 'token无效' });
  const content = readDoc('privacy_policy');
  if (!content) return res.status(500).json({ code: 500, message: '文件读取失败' });
  res.json({ code: 200, data: { title: '隐私政策', content } });
});

// 同意用户协议
app.post('/api/agreement/confirm', (req, res) => {
  const token = req.query.token || req.headers['x-doc-token'];
  if (token !== DOC_TOKEN) return res.status(403).json({ code: 403, message: 'token无效' });
  const { imei, agreed } = req.body;
  if (!imei) return res.status(400).json({ code: 400, message: '缺少IMEI' });
  if (typeof agreed !== 'boolean') return res.status(400).json({ code: 400, message: 'agreed需为bool值' });
  try {
    const db = getDb();
    db.exec("CREATE TABLE IF NOT EXISTS agreement_records (id INTEGER PRIMARY KEY AUTOINCREMENT, imei TEXT NOT NULL UNIQUE, agreed INTEGER NOT NULL DEFAULT 0, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP)");
    db.prepare("INSERT INTO agreement_records (imei, agreed) VALUES (?, ?) ON CONFLICT(imei) DO UPDATE SET agreed=?, updated_at=CURRENT_TIMESTAMP").run(imei, agreed ? 1 : 0, agreed ? 1 : 0);
    res.json({ code: 200, message: '已记录' });
  } catch(e) {
    console.error('agreement confirm error:', e);
    res.status(500).json({ code: 500, message: '记录失败' });
  }
});

// 查询协议同意状态
app.get('/api/agreement/status', (req, res) => {
  const token = req.query.token || req.headers['x-doc-token'];
  if (token !== DOC_TOKEN) return res.status(403).json({ code: 403, message: 'token无效' });
  const imei = req.query.imei;
  if (!imei) return res.status(400).json({ code: 400, message: '缺少IMEI' });
  try {
    const db = getDb();
    db.exec("CREATE TABLE IF NOT EXISTS agreement_records (id INTEGER PRIMARY KEY AUTOINCREMENT, imei TEXT NOT NULL UNIQUE, agreed INTEGER NOT NULL DEFAULT 0, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP)");
    const row = db.prepare("SELECT agreed, updated_at FROM agreement_records WHERE imei = ?").get(imei);
    res.json({ code: 200, data: { agreed: row ? !!row.agreed : false, updated_at: row ? row.updated_at : null } });
  } catch(e) {
    res.status(500).json({ code: 500, message: '查询失败' });
  }
});

app.get('/api/agreement', (req, res) => {
  const token = req.query.token || req.headers['x-doc-token'];
  if (token !== DOC_TOKEN) return res.status(403).json({ code: 403, message: 'token无效' });
  const content = readDoc('user_agreement');
  if (!content) return res.status(500).json({ code: 500, message: '文件读取失败' });
  res.json({ code: 200, data: { title: '用户协议', content } });
});

// Auth routes
app.use('/api/auth', authRoutes);

// 食堂评论
app.use('/api/canteen', require('./routes/canteen'));

// 鸿蒙反馈（需用户登录token）
const { authMiddleware } = require('./middleware/auth');

app.post('/api/feedback', authMiddleware, (req, res) => {
  const { title, content } = req.body;
  if (!title || !title.trim()) return res.status(400).json({ code: 400, message: '反馈标题不能为空' });
  if (!content || !content.trim()) return res.status(400).json({ code: 400, message: '反馈内容不能为空' });
  try {
    const db = getDb();
    const user = db.prepare('SELECT id, username, nickname FROM users WHERE id = ?').get(req.userId);
    if (!user) return res.status(404).json({ code: 404, message: '用户不存在' });
    db.prepare('INSERT INTO feedbacks (user_id, username, nickname, title, content) VALUES (?, ?, ?, ?, ?)')
      .run(user.id, user.username, user.nickname || '', title.trim(), content.trim());
    res.json({ code: 200, message: '反馈已提交' });
  } catch(e) {
    console.error('反馈提交失败:', e);
    res.status(500).json({ code: 500, message: '提交失败' });
  }
});

// 查看我的反馈记录（需登录）
app.get('/api/feedback', authMiddleware, (req, res) => {
  try {
    const db = getDb();
    const list = db.prepare('SELECT id, title, content, created_at FROM feedbacks WHERE user_id = ? ORDER BY id DESC LIMIT 50').all(req.userId);
    res.json({ code: 200, data: list });
  } catch(e) {
    res.status(500).json({ code: 500, message: '查询失败' });
  }
});

// 用户头像
const AVATAR_DIR = path.join(__dirname, 'public', 'avatars');
try { require('fs').mkdirSync(AVATAR_DIR, { recursive: true }); } catch(e) {}

app.post('/api/user/avatar', authMiddleware, (req, res) => {
  const { avatar } = req.body; // base64 图片数据
  if (!avatar) return res.status(400).json({ code: 400, message: '缺少头像数据' });
  try {
    const fs = require('fs');
    const matches = avatar.match(/^data:image\/(png|jpeg|jpg|gif|webp);base64,(.+)$/);
    if (!matches) return res.status(400).json({ code: 400, message: '图片格式不支持，仅限png/jpg/gif/webp' });
    const ext = matches[1] === 'jpeg' ? 'jpg' : matches[1];
    const data = Buffer.from(matches[2], 'base64');
    if (data.length > 128 * 1024) return res.status(400).json({ code: 400, message: '图片不能超过128KB' });
    const filename = 'u' + req.userId + '_' + Date.now() + '.' + ext;
    fs.writeFileSync(path.join(AVATAR_DIR, filename), data);
    const db = getDb();
    // 删除旧头像文件
    const old = db.prepare('SELECT avatar FROM users WHERE id = ?').get(req.userId);
    if (old && old.avatar) { try { fs.unlinkSync(path.join(AVATAR_DIR, old.avatar)); } catch(e) {} }
    db.prepare('UPDATE users SET avatar = ? WHERE id = ?').run(filename, req.userId);
    res.json({ code: 200, message: '头像已更新', data: { avatar: '/avatars/' + filename } });
  } catch(e) {
    console.error('头像上传失败:', e);
    res.status(500).json({ code: 500, message: '上传失败' });
  }
});

// 获取头像（公开，用账号）
app.get('/api/user/avatar/:username', (req, res) => {
  try {
    const db = getDb();
    const user = db.prepare('SELECT avatar FROM users WHERE username = ?').get(req.params.username);
    if (!user || !user.avatar) return res.status(404).json({ code: 404, message: '暂无头像' });
    const fp = path.join(AVATAR_DIR, user.avatar);
    if (!require('fs').existsSync(fp)) return res.status(404).json({ code: 404, message: '头像文件不存在' });
    res.sendFile(fp);
  } catch(e) {
    res.status(500).json({ code: 500, message: '查询失败' });
  }
});

// 修改昵称
app.put('/api/user/nickname', authMiddleware, (req, res) => {
  const { nickname } = req.body;
  if (!nickname || nickname.length < 2 || nickname.length > 5) return res.status(400).json({ code: 400, message: '昵称需2-5个字' });
  for (var i = 0; i < nickname.length; i++) {
    if (nickname.charCodeAt(i) < 0x4e00 || nickname.charCodeAt(i) > 0x9fff) return res.status(400).json({ code: 400, message: '昵称仅限中文字符' });
  }
  try {
    getDb().prepare('UPDATE users SET nickname = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?').run(nickname, req.userId);
    res.json({ code: 200, message: '昵称已更新' });
  } catch(e) { res.status(500).json({ code: 500, message: '更新失败' }); }
});

// 修改密码
app.put('/api/user/password', authMiddleware, (req, res) => {
  const { oldPassword, newPassword } = req.body;
  if (!oldPassword || !newPassword) return res.status(400).json({ code: 400, message: '旧密码和新密码不能为空' });
  if (newPassword.length < 6) return res.status(400).json({ code: 400, message: '新密码至少6位' });
  try {
    const db = getDb();
    const user = db.prepare('SELECT password FROM users WHERE id = ?').get(req.userId);
    if (!user) return res.status(404).json({ code: 404, message: '用户不存在' });
    const bcrypt = require('bcryptjs');
    if (!bcrypt.compareSync(oldPassword, user.password)) return res.status(401).json({ code: 401, message: '旧密码错误' });
    const hashed = bcrypt.hashSync(newPassword, 10);
    db.prepare('UPDATE users SET password = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?').run(hashed, req.userId);
    res.json({ code: 200, message: '密码已更新' });
  } catch(e) { res.status(500).json({ code: 500, message: '修改失败' }); }
});

// 注销账号
app.delete('/api/user/account', authMiddleware, (req, res) => {
  try {
    const db = getDb();
    // 删除关联数据
    db.prepare('DELETE FROM feedbacks WHERE user_id = ?').run(req.userId);
    // 删除头像文件
    const user = db.prepare('SELECT avatar FROM users WHERE id = ?').get(req.userId);
    if (user && user.avatar) { try { require('fs').unlinkSync(path.join(AVATAR_DIR, user.avatar)); } catch(e) {} }
    // 删除用户
    db.prepare('DELETE FROM users WHERE id = ?').run(req.userId);
    res.json({ code: 200, message: '账号已注销' });
  } catch(e) { res.status(500).json({ code: 500, message: '注销失败' }); }
});

// 静态文件：头像
app.use('/avatars', express.static(AVATAR_DIR));

// Admin
const db = getDb();
setupAdminPage(app, db);



// 404
app.use((req, res) => {
  res.status(404).json({ code: 404, message: '接口不存在' });
});

// HTTP (plain, for MATLAB etc.)
app.listen(PORT, '0.0.0.0', () => {
  console.log(`鸿蒙后端 HTTP on port ${PORT}`);
});
