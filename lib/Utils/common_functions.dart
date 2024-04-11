import 'package:flutter/material.dart';
import 'package:track_it_up/Database/product_operations.dart';
import 'package:track_it_up/Database/user_operations.dart';
import 'package:track_it_up/Models/product_model.dart';
import 'package:track_it_up/main.dart';

import 'appcolors.dart';

class CommonFunctions {
  List<Map<String, dynamic>> queryRows = [];
  static var globalContext = NavigationService.navigatorKey.currentContext!;

  static void showErrorSnackbar(String msg) {
    ScaffoldMessenger.of(globalContext).clearSnackBars();
    ScaffoldMessenger.of(globalContext).showSnackBar(SnackBar(
        margin: const EdgeInsets.only(bottom: 70.0, left: 20, right: 20),
        content: Text(
          msg,
          style: const TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5),
        ),
        backgroundColor: Colors.red.withOpacity(.8),
        behavior: SnackBarBehavior.floating));
  }

  static void showSuccessSnackbar(String msg) {
    ScaffoldMessenger.of(globalContext).clearSnackBars();
    ScaffoldMessenger.of(globalContext).showSnackBar(SnackBar(
        margin: const EdgeInsets.only(bottom: 70.0, left: 20, right: 20),
        content: Text(
          msg,
          style: const TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5),
        ),
        backgroundColor: Colors.green.withOpacity(.8),
        behavior: SnackBarBehavior.floating));
  }

  static void showWarningSnackbar(String msg) {
    ScaffoldMessenger.of(globalContext).clearSnackBars();
    ScaffoldMessenger.of(globalContext).showSnackBar(SnackBar(
        margin: const EdgeInsets.only(bottom: 70.0, left: 20, right: 20),
        content: Text(
          msg,
          style: const TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5),
        ),
        backgroundColor: blackColor,
        behavior: SnackBarBehavior.floating));
  }

  Future<List<ProductModel>> getProductList() async {
    queryRows.toList().clear();
    queryRows = await ProductOperations().getAllProductData();

    return queryRows
        .toList()
        .map(
          (e) => ProductModel.fromJson(e),
        )
        .toList();
  }

  Future<List<ProductModel>> getUserList() async {
    queryRows.toList().clear();
    queryRows = await UserOperations().getAllUsers();
    print(queryRows);
    // return queryRows
    //     .toList()
    //     .map(
    //       (e) => ProductModel.fromJson(e),
    //     )
    //     .toList();
    return [];
  }
}
