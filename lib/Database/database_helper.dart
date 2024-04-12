import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const databaseName = 'trackitupdatabase.db';
  static const databaseVersion = 1;
  static const productDBTableName = "productTable";
  static const userDBTableName = "userTable";
  static const mealDBTableName = "mealTable";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initialiseDatabase();
    return _database;
  }

  _initialiseDatabase() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = join(directory.path, databaseName);
      return await openDatabase(path,
          version: databaseVersion, onCreate: _onCreate);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE IF NOT EXISTS productTable(
    id INTEGER PRIMARY KEY,
    prodId TEXT NOT NULL,
    name TEXT NOT NULL,
    foodtype TEXT NOT NULL,
    calories TEXT NOT NULL,  
    protein TEXT NOT NULL,
    carbohydrate TEXT NOT NULL,
    image TEXT NOT NULL
    );
  ''');
    await db.execute('''
  CREATE TABLE IF NOT EXISTS userTable(
    id INTEGER PRIMARY KEY,
    name VARCHAR,
    height TEXT NOT NULL, 
    weight TEXT NOT NULL
    );
  ''');
    await db.execute('''
  CREATE TABLE IF NOT EXISTS mealTable(
    id INTEGER PRIMARY KEY,
    prodId TEXT NOT NULL,
    name TEXT NOT NULL,
    quantity TEXT NOT NULL,
    protein TEXT NOT NULL,
    carbohydrate TEXT NOT NULL,
    totalCalories TEXT NOT NULL,
    createdOn TEXT NOT NULL,
    updatedAt TEXT NOT NULL,
    mealType TEXT NOT NULL,
    userId TEXT NOT NULL
    );
  ''');
  }

  Future<int> insert(Map<String, dynamic> row, String tableName) async {
    Database? db = await instance.database;
    return await db!.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> quaryAll(String tableName) async {
    Database? db = await instance.database;

    return await db!.query(tableName);
  }

  Future<int> deleteRecordFromTable(String id, String tableName) async {
    Database? db = await instance.database;

    return await db!.delete(tableName, where: 'id =?', whereArgs: [id]);
  }

  checkIfPresent(String checkKey, String value, String tableName) async {
    Database? db = await database;
    var data = await db!
        .rawQuery('SELECT * FROM $tableName WHERE $checkKey = ?', [value]);
    return data.toList().isNotEmpty;
  }

  dropTable(String tableName) async {
    Database? db = await database;
    return await db!.rawQuery("DROP TABLE IF EXISTS $tableName");
  }

  Future<int> updateTable(Map<String, dynamic> row, String tableName) async {
    Database? db = await instance.database;
    int id = int.parse(row["id"]);

    return await db!.update(tableName, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> truncateTableIfExists(String tableName) async {
    Database? db = await instance.database;
    final tableExist = await tableExists(tableName);
    if (tableExist) {
      await db!.execute('DELETE FROM $tableName');
    }
  }

  Future<bool> tableExists(String tableName) async {
    Database? db = await instance.database;
    final result = await db!.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'",
    );
    return result.isNotEmpty;
  }
}
