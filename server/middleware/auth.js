const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'harmony_secret_key_2024';

function generateToken(userId) {
  return jwt.sign({ userId }, JWT_SECRET, { expiresIn: '7d' });
}

function authMiddleware(req, res, next) {
  const authHeader = req.headers.authorization;
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ code: 401, message: '未登录' });
  }

  const token = authHeader.split(' ')[1];
  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.userId = decoded.userId;
    next();
  } catch {
    return res.status(401).json({ code: 401, message: '登录已过期' });
  }
}

module.exports = { generateToken, authMiddleware, JWT_SECRET };
