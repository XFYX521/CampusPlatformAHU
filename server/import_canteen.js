const Database = require('better-sqlite3');
const fs = require('fs');
const db = new Database('data/harmony.db');
db.pragma('journal_mode = WAL');
const data = JSON.parse(fs.readFileSync('doucuments/canteen_data.json', 'utf8'));

db.exec('PRAGMA foreign_keys = OFF');
db.exec('DROP TABLE IF EXISTS windows;');
db.exec('DROP TABLE IF EXISTS floors;');
db.exec('DROP TABLE IF EXISTS canteens;');
db.exec(`CREATE TABLE IF NOT EXISTS canteens (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, created_at DATETIME DEFAULT CURRENT_TIMESTAMP);`);
db.exec(`CREATE TABLE IF NOT EXISTS floors (id INTEGER PRIMARY KEY AUTOINCREMENT, canteen_id INTEGER NOT NULL, name TEXT NOT NULL, created_at DATETIME DEFAULT CURRENT_TIMESTAMP);`);
db.exec(`CREATE TABLE IF NOT EXISTS windows (id INTEGER PRIMARY KEY, canteen_id INTEGER NOT NULL, floor_id INTEGER NOT NULL, name TEXT NOT NULL, created_at DATETIME DEFAULT CURRENT_TIMESTAMP);`);
db.exec('PRAGMA foreign_keys = ON');

const insC = db.prepare('INSERT INTO canteens (id, name) VALUES (?, ?)');
for (const c of data.canteens) insC.run(c[0], c[1]);

const insF = db.prepare('INSERT INTO floors (id, canteen_id, name) VALUES (?, ?, ?)');
for (const f of data.floors) insF.run(f[0], f[1], f[2]);

const insW = db.prepare('INSERT OR REPLACE INTO windows (id, canteen_id, floor_id, name) VALUES (?, ?, ?, ?)');
for (const w of data.windows) insW.run(w[0], w[1], w[2], w[3]);

console.log('导入完成:', data.canteens.length, '食堂,', data.floors.length, '楼层,', data.windows.length, '窗口');
db.close();
