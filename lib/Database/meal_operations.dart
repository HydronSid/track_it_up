import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:track_it_up/Utils/common_functions.dart';

import 'database_helper.dart';

class MealOperations {
  List<Map<String, dynamic>> queryRows = [];

  getAllMealData() async {
    queryRows =
        await DatabaseHelper.instance.quaryAll(DatabaseHelper.mealDBTableName);

    return queryRows;
  }

  getAllMealByType(
    String type,
    String uId,
  ) async {
    Database? db = await DatabaseHelper.instance.database;

    return await db!.rawQuery(
        "SELECT * FROM ${DatabaseHelper.mealDBTableName} WHERE mealType=? and userId=? and createdOn=?",
        [type, uId, CommonFunctions().returnAppDateFormat(DateTime.now())]);
  }

  getAllTodayMealData(
    String uId,
  ) async {
    Database? db = await DatabaseHelper.instance.database;

    return await db!.rawQuery(
        "SELECT * FROM ${DatabaseHelper.mealDBTableName} WHERE  userId=? and createdOn=?",
        [uId, CommonFunctions().returnAppDateFormat(DateTime.now())]);
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
    required String serving,
    required String grams,
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
      "serving": serving,
      "grams": grams,
    }, DatabaseHelper.mealDBTableName);

    debugPrint('the inserted id is $i');
  }
}
