import 'package:flutter/material.dart';
import 'database_helper.dart';

class ProductOperations {
  List<Map<String, dynamic>> queryRows = [];

  turncateProductTable() async {
    await DatabaseHelper.instance
        .truncateTableIfExists(DatabaseHelper.productDBTableName);
  }

  getAllProductData() async {
    queryRows = await DatabaseHelper.instance
        .quaryAll(DatabaseHelper.productDBTableName);

    return queryRows;
  }

  insertingProduct({
    required String prodId,
    required String name,
    required String fats,
    required String foodtype,
    required String calories,
    required String protein,
    required String carbohydrate,
    required String image,
  }) async {
    int i = await DatabaseHelper.instance.insert({
      "prodId": prodId,
      "name": name,
      "fats": fats,
      "foodtype": foodtype,
      "calories": calories,
      "protein": protein,
      "carbohydrate": carbohydrate,
      "image": image,
    }, DatabaseHelper.productDBTableName);

    debugPrint('the inserted id is $i');
  }

  deletingProduct({required String id}) async {
    int rowsAffected = await DatabaseHelper.instance
        .deleteRecordFromTable(id, DatabaseHelper.productDBTableName);

    debugPrint('Rows affected $rowsAffected');
  }
}
