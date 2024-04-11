import 'package:flutter/material.dart';

import 'database_helper.dart';

class MealOperations {
  List<Map<String, dynamic>> queryRows = [];

  getAllMealByType(String type, String uId) async {
    queryRows = await DatabaseHelper.instance
        .quaryAllByType(DatabaseHelper.mealDBTableName, type, uId);

    return queryRows;
  }

  insertingMeal({
    required String prodId,
    required String name,
    required String quantity,
    required String totalCalories,
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
      "createdOn": createdOn,
      "updatedAt": updatedAt,
    }, DatabaseHelper.productDBTableName);

    debugPrint('the inserted id is $i');
  }
}
