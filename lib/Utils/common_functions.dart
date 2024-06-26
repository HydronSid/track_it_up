import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:track_it_up/Database/database_helper.dart';
import 'package:track_it_up/Database/meal_operations.dart';
import 'package:track_it_up/Database/product_operations.dart';
import 'package:track_it_up/Database/user_operations.dart';
import 'package:track_it_up/Models/meal_model.dart';
import 'package:track_it_up/Models/product_model.dart';
import 'package:track_it_up/Models/user_model.dart';
import 'package:track_it_up/main.dart';

import 'appcolors.dart';
import 'local_shared_preferences.dart';

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

  Future<UserModel> getUser() async {
    String userName = await LocalPreferences().getUserName() ?? "";
    queryRows.toList().clear();
    queryRows = await UserOperations()
        .getUserData('name', userName, DatabaseHelper.userDBTableName);

    return UserModel.fromJson(queryRows.first);
  }

  Future<List<MealModel>> getMealByTypeDateUser(
    String type,
  ) async {
    UserModel user = await CommonFunctions().getUser();
    queryRows.toList().clear();
    queryRows = await MealOperations().getAllMealByType(type, user.id!);

    return queryRows
        .toList()
        .map(
          (e) => MealModel.fromJson(e),
        )
        .toList();
  }

  Future getAllTodayMealData() async {
    UserModel user = await CommonFunctions().getUser();
    queryRows.toList().clear();
    queryRows = await MealOperations().getAllTodayMealData(user.id!);

    var mealList = queryRows
        .toList()
        .map(
          (e) => MealModel.fromJson(e),
        )
        .toList();

    double consumedCal = 0.0, consumedProtein = 0.0, consumedCarbs = 0.0;
    double remainingCal = 0.0, remainingProtein = 0.0, remainingCarbs = 0.0;
    for (var element in mealList) {
      consumedCal += double.parse(element.totalCalories!);
      consumedProtein += double.parse(element.protein!);
      consumedCarbs += double.parse(element.carbohydrate!);
    }

    if (consumedCal > double.parse(user.requiredCal!)) {
      remainingCal = 0.0;
    } else {
      remainingCal = double.parse(user.requiredCal!) - consumedCal;
    }
    if (consumedProtein > double.parse(user.requiredProtein!)) {
      remainingProtein = 0.0;
    } else {
      remainingProtein = double.parse(user.requiredProtein!) - consumedProtein;
    }

    if (consumedCarbs > double.parse(user.requiredCarbs!)) {
      remainingCarbs = 0.0;
    } else {
      remainingCarbs = double.parse(user.requiredCarbs!) - consumedCarbs;
    }

    return [
      consumedCal,
      consumedProtein,
      consumedCarbs,
      remainingCal,
      remainingProtein,
      remainingCarbs
    ];
  }

  String returnAppDateFormat(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String returnTotalMealCalories(List<MealModel> meal) {
    if (meal.isEmpty) {
      return "0";
    }

    double calories = 0.0;

    for (var element in meal) {
      calories += double.parse(element.totalCalories!);
    }

    return calories.toStringAsFixed(2);
  }
}
