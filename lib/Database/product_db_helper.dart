import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProductDbHelper {
  static const _productDBName = 'productdatabase.db';
  static const _productDBVersion = 1;
  static const _productDBTableName = "productTable";

  static const id = "id";
  static const prodId = "prodId";
  static const name = "name";
  static const fats = "fats";
  static const foodtype = "foodtype";
  static const calories = "calories";
  static const protein = "protein";
  static const carbohydrate = "carbohydrate";
  static const image = "image";

  ProductDbHelper._privateConstructor();

  static final ProductDbHelper productInstance =
      ProductDbHelper._privateConstructor();

  static Database? _productDatabase;

  Future<Database?> get database async {
    if (_productDatabase != null) return _productDatabase;
    _productDatabase = await _initialiseDatabase();
    return _productDatabase;
  }

  _initialiseDatabase() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = join(directory.path, _productDBName);
      return await openDatabase(path,
          version: _productDBVersion, onCreate: _onCreate);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE IF NOT EXISTS productTable(
    $id INTEGER PRIMARY KEY,
    $prodId TEXT NOT NULL,
    $name TEXT NOT NULL,
    $fats TEXT NOT NULL, 
    $foodtype TEXT NOT NULL,
    $calories TEXT NOT NULL,  
    $protein TEXT NOT NULL,
    $carbohydrate TEXT NOT NULL,
    $image TEXT NOT NULL
    );
  ''');
  }

  Future turncatetable() async {
    Database? db = await productInstance.database;

    await truncateTableIfExists();
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await productInstance.database;
    return await db!.insert(ProductDbHelper._productDBTableName, row);
  }

  Future<List<Map<String, dynamic>>> quaryAll() async {
    Database? db = await productInstance.database;

    return await db!.query(_productDBTableName);
  }

  Future<int> delete(int id) async {
    Database? db = await productInstance.database;

    return await db!
        .delete(_productDBTableName, where: '$prodId =?', whereArgs: [id]);
  }

  checkProduct(String pid) async {
    Database? db = await database;
    var data = await db!
        .rawQuery("SELECT * FROM $_productDBTableName WHERE $prodId=$pid");
    return data;
  }

  dropTable() async {
    Database? db = await database;
    return await db!.rawQuery("DROP TABLE IF EXISTS $_productDBTableName");
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await productInstance.database;
    int id = int.parse(row[prodId]);

    return await db!.update(_productDBTableName, row,
        where: '$prodId = ?', whereArgs: [id]);
  }

  // sumFinalProductTotal() async {
  //   Database? db = await database;
  //   var data = await db!.rawQuery("SELECT SUM($total) FROM $_cartDBTableName");
  //   return data;
  // }

  Future<void> truncateTableIfExists() async {
    Database? db = await productInstance.database;
    final tableExist = await tableExists();
    if (tableExist) {
      await db!.execute('DELETE FROM $_productDBTableName');
    }
  }

  Future<bool> tableExists() async {
    Database? db = await productInstance.database;
    final result = await db!.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$_productDBTableName'",
    );
    return result.isNotEmpty;
  }
}

List<Map<String, dynamic>> queryRows = [];

turncateCart() async {
  await ProductDbHelper.productInstance
      .turncatetable(); // debugPrint('Rows affected $rowsAffected');
}

getAllData() async {
  queryRows = await ProductDbHelper.productInstance.quaryAll();

  return queryRows;
}

insertingCart({
  required String prodId,
  required String name,
  required String fats,
  required String foodtype,
  required String calories,
  required String protein,
  required String carbohydrate,
  required String image,
}) async {
  int i = await ProductDbHelper.productInstance.insert({
    ProductDbHelper.prodId: prodId,
    ProductDbHelper.name: name,
    ProductDbHelper.fats: fats,
    ProductDbHelper.foodtype: foodtype,
    ProductDbHelper.calories: calories,
    ProductDbHelper.protein: protein,
    ProductDbHelper.carbohydrate: carbohydrate,
    ProductDbHelper.image: image,
  });

  debugPrint('the inserted id is $i');
}

deletingCart({required String id}) async {
  int rowsAffected =
      await ProductDbHelper.productInstance.delete(int.parse(id));

  debugPrint('Rows affected $rowsAffected');
}
