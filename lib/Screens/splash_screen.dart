import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:track_it_up/Database/database_helper.dart';
import 'package:track_it_up/Database/product_operations.dart';
import 'package:track_it_up/Utils/appcolors.dart';
import 'package:track_it_up/Utils/local_shared_preferences.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'login_screen.dart';
import 'main_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    nb.setStatusBarColor(bgColor);
    getLoginStatus();
    super.initState();
  }

  void getLoginStatus() async {
    bool status = await LocalPreferences().getLoginBool() ?? false;

    final tableExist = await DatabaseHelper.instance
        .tableExists(DatabaseHelper.productDBTableName);

    if (tableExist) {
      await DatabaseHelper.instance
          .truncateTableIfExists(DatabaseHelper.productDBTableName);
    }

    String responce =
        await rootBundle.loadString('assets/images/allproducts.json');
    List<dynamic> extractedData = await json.decode(responce);

    for (var element in extractedData) {
      ProductOperations().insertingProduct(
          prodId: element["prodId"],
          name: element["name"],
          fats: element["fats"],
          foodtype: element["foodtype"],
          calories: element["calories"],
          protein: element["protein"],
          carbohydrate: element["carbohydrate"],
          image: element["image"]);
    }

    Future.delayed(const Duration(seconds: 3), () {
      if (status) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainHomeScreen(
                initPageNumber: 0,
              ),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Image.asset(
          "assets/images/app_logo.png",
          height: size.height * 0.15,
          width: size.width * 0.5,
        ),
      ),
    );
  }
}
