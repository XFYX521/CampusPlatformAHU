const Database = require('better-sqlite3');
const path = require('path');

const DB_PATH = path.join(__dirname, 'data', 'harmony.db');
let db;

function getDb() {
  if (!db) {
    db = new Database(DB_PATH);
    db.pragma('journal_mode = WAL');
    db.pragma('foreign_keys = ON');
    initTables();
  }
  return db;
}

function initTables() {
  db.exec(`
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT UNIQUE NOT NULL,
      password TEXT NOT NULL,
      nickname TEXT DEFAULT '',
      email TEXT DEFAULT '',
      avatar TEXT DEFAULT '',
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    CREATE TABLE IF NOT EXISTS verification_codes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      email TEXT NOT NULL,
      code TEXT NOT NULL,
      used INTEGER DEFAULT 0,
      expires_at DATETIME NOT NULL,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    CREATE TABLE IF NOT EXISTS login_attempts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ip TEXT NOT NULL,
      username TEXT DEFAULT '',
      attempt_time DATETIME DEFAULT CURRENT_TIMESTAMP,
      success INTEGER DEFAULT 0,
      login_source TEXT DEFAULT '',
      login_role TEXT DEFAULT ''
    );
    CREATE INDEX IF NOT EXISTS idx_login_time ON login_attempts(attempt_time DESC);
    CREATE TABLE IF NOT EXISTS feedbacks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      username TEXT NOT NULL,
      nickname TEXT DEFAULT '',
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    DROP TABLE IF EXISTS comment_votes;
    DROP TABLE IF EXISTS comments;
    DROP TABLE IF EXISTS windows;
    DROP TABLE IF EXISTS floors;
    DROP TABLE IF EXISTS canteens;
    CREATE TABLE IF NOT EXISTS canteens (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    CREATE TABLE IF NOT EXISTS floors (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      canteen_id INTEGER NOT NULL,
      name TEXT NOT NULL,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    CREATE TABLE IF NOT EXISTS windows (
      id INTEGER PRIMARY KEY,
      canteen_id INTEGER NOT NULL,
      floor_id INTEGER NOT NULL,
      name TEXT NOT NULL,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    CREATE TABLE IF NOT EXISTS comments (
      id TEXT PRIMARY KEY,
      window_id INTEGER NOT NULL,
      user_id INTEGER NOT NULL,
      content TEXT NOT NULL,
      image TEXT DEFAULT '',
      likes INTEGER DEFAULT 0,
      dislikes INTEGER DEFAULT 0,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    CREATE TABLE IF NOT EXISTS comment_votes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      comment_id INTEGER NOT NULL,
      user_id INTEGER NOT NULL,
      type INTEGER NOT NULL,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      UNIQUE(comment_id, user_id)
    );
    INSERT OR IGNORE INTO canteens (id, name) VALUES
      (1,'桔园'),(2,'梅园'),(3,'榴园'),(4,'梧桐园'),(5,'桂园'),(6,'蕙园');
    INSERT OR IGNORE INTO floors (id, canteen_id, name) VALUES
      (1,1,'一楼'),(2,1,'二楼'),(3,1,'三楼'),
      (4,2,'一楼'),(5,2,'二楼'),(6,2,'三楼'),
      (7,3,'一楼'),(8,3,'二楼'),(9,3,'三楼'),
      (10,4,'一楼'),(11,4,'二楼'),
      (12,5,'一楼'),(13,5,'二楼'),(14,5,'三楼'),
      (15,6,'一楼'),(16,6,'二楼');
  `);
}

module.exports = { getDb };
