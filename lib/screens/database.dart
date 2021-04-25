import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'User.dart';
// data model class

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), 'registration.db'),
        onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE Vehicle(
        number TEXT PRIMARY KEY,model TEXT,make TEXT,fuelType TEXT,transmission TEXT
        )
        ''');
    }, version: 1);
  }

  newUser(User newUser) async {
    final db = await database;
    var result = await db.rawInsert('''
    INSERT INTO Vehicle (number,model,make,fuelType,transmission) VALUES(?,?,?,?,?)
    ''', [
      newUser.number,
      newUser.model,
      newUser.make,
      newUser.fuelType,
      newUser.transmission
    ]);
    return result;
  }

  Future<dynamic> getUser() async {
    final db = await database;
    List<Map> title = await db.rawQuery('SELECT * FROM Vehicle');
    if (title.length == 0) {
      return null;
    } else {
      var resMap = title;
      return resMap.isNotEmpty ? resMap : Null;
    }
  }
  // SQL string to create the database

  // Database helper metho
}
