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
  final String tableUser = "User";
  final String columnUsername = "username";
  final String columnPassword = "password";

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
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  // create new table
  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableUser (id INTEGER PRIMARY KEY, $columnUsername TEXT, $columnPassword TEXT)");
    print("Table is created");
  }

  // insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert(tableUser, user.toMap());
    return res;
  }

  // get all user
  Future<List> getAllUsers() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery('SELECT * FROM $tableUser');
    return result.toList();
  }

  //get count of user table
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableUser'));
  }

  // get one user
  Future<User> getUser(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableUser,
        columns: [columnUsername, columnPassword],
        where: 'id = ?',
        whereArgs: [id]);
        
    if (result.length > 0) {
      return new User.fromMap(result.first);
    }
    return null;
  }

  //deletion
  Future<int> deleteUser(String username) async {
    var dbClient = await db;
    int res = await dbClient
        .delete(tableUser, where: '$columnUsername = ?', whereArgs: [username]);
    return res;
  }

  Future<int> updateNote(User user) async {
    var dbClient = await db;
    return await dbClient.update(tableUser, user.toMap(),
        where: "$columnUsername = ?", whereArgs: [user.username]);
  }

  //close database
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
