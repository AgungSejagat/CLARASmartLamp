//Class DB Helper diperlukan untuk mengolah data di SQL dari flutter. Seperti create, update, delete

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) async {
          await db.execute(
          'CREATE TABLE room(id TEXT PRIMARY KEY, location TEXT)');
          await db.execute(
          'INSERT OR IGNORE INTO room VALUES("1", "kamar tidur"), ("2", "kamar mandi"), ("3", "ruang tamu")');

      return db.execute(
          'CREATE TABLE user_devices(espId TEXT PRIMARY KEY, name TEXT, location TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
    );
  }

  static delete(String table, String selectedId) async {
    final db = await DBHelper.database();
    db.delete(table, where: 'espId = ?', whereArgs: [selectedId]);
  }

  static deleteByRoom(String table, String location) async {
    final db = await DBHelper.database();
    db.delete(table, where: 'location = ?', whereArgs: [location]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
