import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper{
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'results.db'),
        onCreate: (db, version) {
          return db.execute('CREATE TABLE result_table(id INTEGER PRIMARY KEY , name TEXT , pending TEXT)');
        }, version: 1);
  }

  static Future<List<Map<String, Object?>>> addResult(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
    );
     Future<List<Map<String, Object?>>> id = db.query(table, orderBy: "id DESC", limit: 1);
     return id;
  }

  static Future<void> updateOperation(int id , String name) async{
    final db = await DBHelper.database();
    await db.rawUpdate(
        'UPDATE result_table SET pending = ? , name = ? WHERE id = ?',
        ['false', name , id.toString()]);
  }

  static Future<List<Map>> getData(String pending) async {
    final db = await DBHelper.database();
    List<Map> result = await db.rawQuery('SELECT * FROM result_table WHERE pending=?', [pending]);
    return result;
  }
}
