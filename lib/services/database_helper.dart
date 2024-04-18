import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:superapp/models/user_model.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = 'users.db';

  static Future<Database> _getDatabase() async {
     
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }  

    return openDatabase(join(await getDatabasesPath(), _dbName),
      onCreate:(db, version) async => await db.execute(
        'CREATE TABLE Users(id INTEGER PRIMARY KEY, username TEXT NOT NULL, password TEXT NOT NULL);'
      ),
      version: _version
    );
  }

  static Future<int> addUser(User user) async {
    final db = await _getDatabase();

    return await db.insert('Users', user.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<User> getUser(String username) async {
    final db = await _getDatabase();

    final result = await db.query('Users', where: 'username = ?', whereArgs: [username]);

    if (result.isNotEmpty) {
      return User.fromJson(result[0]);
    } 
    return const User(username: 'user', password: 'pw');
  }
}