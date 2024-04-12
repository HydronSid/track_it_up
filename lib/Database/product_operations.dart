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
    required String foodtype,
    required String calories,
    required String protein,
    required String carbohydrate,
    required String serving,
    required String image,
    required String grams,
  }) async {
    int i = await DatabaseHelper.instance.insert({
      "prodId": prodId,
      "name": name,
      "foodtype": foodtype,
      "calories": calories,
      "protein": protein,
      "carbohydrate": carbohydrate,
      "serving": serving,
      "image": image,
      "grams": grams,
    }, DatabaseHelper.productDBTableName);

    debugPrint('the inserted id is $i');
  }

  deletingProduct({required String id}) async {
    int rowsAffected = await DatabaseHelper.instance
        .deleteRecordFromTable(id, DatabaseHelper.productDBTableName);

    debugPrint('Rows affected $rowsAffected');
  }
}
