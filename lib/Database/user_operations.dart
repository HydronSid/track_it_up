import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class UserOperations {
  List<Map<String, dynamic>> queryRows = [];

  turncateUserTable() async {
    await DatabaseHelper.instance
        .truncateTableIfExists(DatabaseHelper.userDBTableName);
  }

  getAllUsers() async {
    queryRows =
        await DatabaseHelper.instance.quaryAll(DatabaseHelper.userDBTableName);

    return queryRows;
  }

  getUserData(String checkKey, String value, String tableName) async {
    Database? db = await DatabaseHelper.instance.database;
    var data = await db!
        .rawQuery('SELECT * FROM $tableName WHERE $checkKey = ?', [value]);
    return data;
  }

  Future insertUser({
    required String name,
    required String height,
    required String weight,
  }) async {
    int i = await DatabaseHelper.instance.insert({
      "name": name,
      "height": height,
      "weight": weight,
    }, DatabaseHelper.userDBTableName);

    debugPrint('the inserted id is $i');
  }

  deletingProduct({required String id}) async {
    int rowsAffected = await DatabaseHelper.instance
        .deleteRecordFromTable(id, DatabaseHelper.userDBTableName);

    debugPrint('Rows affected $rowsAffected');
  }
}
