const express = require('express');
const path = require('path');
const fs = require('fs');
const router = express.Router();
const { authMiddleware } = require('../middleware/auth');
const { getDb } = require('../db');

const IMG_DIR = path.join(__dirname, '..', 'public', 'canteen');
try { fs.mkdirSync(IMG_DIR, { recursive: true }); } catch(e) {}

// 所有窗口列表
router.get('/windows', (req, res) => {
  const windows = getDb().prepare('SELECT id, canteen_id, floor_id, name FROM windows').all();
  res.json({ code: 200, data: windows });
});

// 评论列表 ?id=窗口id
router.get('/windows/comments', (req, res) => {
  try {
    const db = getDb();
    var userId = null;
    const auth = req.headers.authorization || '';
    if (auth.startsWith('Bearer ')) {
      try {
        const jwt = require('jsonwebtoken');
        const decoded = jwt.verify(auth.slice(7), require('../middleware/auth').JWT_SECRET);
        userId = decoded.userId;
      } catch(e) {}
    }
    var rows = db.prepare(`
      SELECT c.id, c.window_id, c.user_id, c.content, c.image, c.likes, c.dislikes, c.created_at,
             u.username, u.nickname, u.avatar
      FROM comments c LEFT JOIN users u ON c.user_id = u.id
      WHERE c.window_id = ? ORDER BY c.created_at DESC
    `).all(req.query.id);
    rows = rows.map(function(r) {
      var myVote = null;
      if (userId) {
        var vote = db.prepare('SELECT type FROM comment_votes WHERE comment_id = ? AND user_id = ?').get(r.id, userId);
        if (vote) myVote = vote.type;
      }
      return {
        id: r.id, window_id: r.window_id, content: r.content,
        image: r.image, likes: r.likes, dislikes: r.dislikes,
        created_at: r.created_at, my_vote: myVote,
        user: { id: r.user_id, username: r.username, nickname: r.nickname, avatar: r.avatar }
      };
    });
    res.json({ code: 200, data: rows });
  } catch(e) { console.error(e); res.status(500).json({ code: 500, message: '查询失败' }); }
});

// 发表评论 ?id=窗口id
router.post('/windows/comments', authMiddleware, (req, res) => {
  const { content, image } = req.body;
  if (!content || !content.trim()) return res.status(400).json({ code: 400, message: '内容不能为空' });
  if (content.length > 500) return res.status(400).json({ code: 400, message: '不能超过500字' });
  var imageName = '';
  if (image) {
    var matches = image.match(/^data:image\/(png|jpeg|jpg|gif|webp);base64,(.+)$/);
    if (!matches) return res.status(400).json({ code: 400, message: '图片格式不支持' });
    var ext = matches[1] === 'jpeg' ? 'jpg' : matches[1];
    var buf = Buffer.from(matches[2], 'base64');
    if (buf.length > 128 * 1024) return res.status(400).json({ code: 400, message: '图片不能超过128KB' });
    imageName = 'c_' + Date.now() + '_' + req.userId + '.' + ext;
    fs.writeFileSync(path.join(IMG_DIR, imageName), buf);
  }
  try {
    const db = getDb();
    var wid = req.query.id;
    var ts = Date.now();
    var cid = String(wid) + String(ts);
    db.prepare('INSERT INTO comments (id, window_id, user_id, content, image) VALUES (?, ?, ?, ?, ?)').run(cid, wid, req.userId, content.trim(), imageName);
    res.json({ code: 200, message: '评论成功', data: { id: cid } });
  } catch(e) { res.status(500).json({ code: 500, message: '评论失败' }); }
});

// 删除评论 ?id=评论id
router.delete('/comments', authMiddleware, (req, res) => {
  try {
    var db = getDb();
    var comment = db.prepare('SELECT * FROM comments WHERE id = ?').get(req.query.id);
    if (!comment) return res.status(404).json({ code: 404, message: '评论不存在' });
    if (comment.user_id !== req.userId) return res.status(403).json({ code: 403, message: '只能删除自己的' });
    if (comment.image) { try { fs.unlinkSync(path.join(IMG_DIR, comment.image)); } catch(e) {} }
    db.prepare('DELETE FROM comment_votes WHERE comment_id = ?').run(req.query.id);
    db.prepare('DELETE FROM comments WHERE id = ?').run(req.query.id);
    res.json({ code: 200, message: '已删除' });
  } catch(e) { res.status(500).json({ code: 500, message: '删除失败' }); }
});

// 点赞/踩 ?id=评论id
router.post('/comments/vote', authMiddleware, (req, res) => {
  var { type } = req.body;
  if (type !== 1 && type !== -1) return res.status(400).json({ code: 400, message: 'type需为1或-1' });
  try {
    var db = getDb();
    var comment = db.prepare('SELECT id FROM comments WHERE id = ?').get(req.query.id);
    if (!comment) return res.status(404).json({ code: 404, message: '评论不存在' });
    var existing = db.prepare('SELECT * FROM comment_votes WHERE comment_id = ? AND user_id = ?').get(req.query.id, req.userId);
    if (existing) {
      if (existing.type === type) {
        db.prepare('DELETE FROM comment_votes WHERE id = ?').run(existing.id);
        db.prepare('UPDATE comments SET ' + (type === 1 ? 'likes' : 'dislikes') + ' = MAX(0, ' + (type === 1 ? 'likes' : 'dislikes') + ' - 1) WHERE id = ?').run(req.query.id);
        return res.json({ code: 200, message: '已取消' });
      } else {
        db.prepare('UPDATE comment_votes SET type = ? WHERE id = ?').run(type, existing.id);
        db.prepare('UPDATE comments SET likes = likes ' + (type === 1 ? '+ 1' : '- 1') + ', dislikes = dislikes ' + (type === 1 ? '- 1' : '+ 1') + ' WHERE id = ?').run(req.query.id);
        return res.json({ code: 200, message: '已更新' });
      }
    }
    db.prepare('INSERT INTO comment_votes (comment_id, user_id, type) VALUES (?, ?, ?)').run(req.query.id, req.userId, type);
    db.prepare('UPDATE comments SET ' + (type === 1 ? 'likes' : 'dislikes') + ' = ' + (type === 1 ? 'likes' : 'dislikes') + ' + 1 WHERE id = ?').run(req.query.id);
    res.json({ code: 200, message: '投票成功' });
  } catch(e) { res.status(500).json({ code: 500, message: '投票失败' }); }
});

// 评论图片
router.use('/images', express.static(IMG_DIR));

module.exports = router;
