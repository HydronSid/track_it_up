import 'package:flutter/material.dart';
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
