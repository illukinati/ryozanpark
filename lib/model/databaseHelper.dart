import 'dart:io';

import 'package:path/path.dart';
import 'package:ryozanpark/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  // create new table
  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User (id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
    print("Table is created");
  }

  // insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  //get count of user table
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite
        .firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM User'));
  }

  // get all user
  Future<List> getAllUsers() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery('SELECT * FROM User');
    return result.toList();
  }

  // get one user
  Future<User> getUser(String username) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery('SELECT * FROM User WHERE username = $username');

    if (result.length > 0) {
      return new User.fromMap(result.first);
    }

    return null;
  }

  //close database
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
