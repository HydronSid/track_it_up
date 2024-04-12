import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class MealOperations {
  List<Map<String, dynamic>> queryRows = [];

  getAllMealData() async {
    queryRows =
        await DatabaseHelper.instance.quaryAll(DatabaseHelper.mealDBTableName);

    return queryRows;
  }

  getAllMealByType(String type, String uId) async {
    Database? db = await DatabaseHelper.instance.database;

    return await db!.rawQuery(
        "SELECT * FROM ${DatabaseHelper.mealDBTableName} WHERE mealType=? and userId=?",
        [type, uId]);
  }

  insertingMeal({
    required String prodId,
    required String name,
    required String quantity,
    required String totalCalories,
    required String protein,
    required String carbohydrate,
    required String createdOn,
    required String updatedAt,
    required String mealType,
    required String userId,
  }) async {
    int i = await DatabaseHelper.instance.insert({
      "prodId": prodId,
      "name": name,
      "quantity": quantity,
      "totalCalories": totalCalories,
      "mealType": mealType,
      "userId": userId,
      "protein": protein,
      "carbohydrate": carbohydrate,
      "createdOn": createdOn,
      "updatedAt": updatedAt,
    }, DatabaseHelper.mealDBTableName);

    debugPrint('the inserted id is $i');
  }
}
