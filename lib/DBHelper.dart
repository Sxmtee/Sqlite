import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  String dbName = "contacts.db";
  String tableName = "contact";
  int dbVersion = 1;
  DbHelper() {
    initializeDb();
  }

  Future<Database> initializeDb() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, dbName),
      version: dbVersion,
      onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE contact(id INTEGER PRIMARY KEY, name TEXT NOT NULL, phone TEXT NOT NULL)");
      },
    );
  }

  Future<int> saveContact(Map<String, dynamic> contact) async {
    int result = 0;
    final Database db = await initializeDb();
    result = await db.insert(tableName, contact);
    return result;
  }

  Future<List<Map<String, dynamic>>> selectContact() async {
    final Database db = await initializeDb();
    var result = await db.rawQuery("SELECT * FROM" + tableName);
    return result;
  }

  Future<int> update(Map<String, dynamic> contact) async {
    final Database db = await initializeDb();
    return await db.update(tableName, contact);
  }

  Future<int> delete(int id) async {
    final Database db = await initializeDb();
    return await db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }
}
