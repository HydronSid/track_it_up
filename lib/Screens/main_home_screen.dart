import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_it_up/Screens/home_screen.dart';
import 'package:track_it_up/Utils/appcolors.dart';

import 'all_product_screen.dart';
import 'navigation_bar_controller.dart';

class MainHomeScreen extends StatefulWidget {
  final int initPageNumber;
  const MainHomeScreen({super.key, required this.initPageNumber});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final _homeController = BottomNavigiationController();

  List items = [
    const HomeScreen(),
    const AllProductScreen(
      isAppBar: false,
    ),
    Container(),
    Container(),
  ];

  int _selectedTab = 0;

  Future<bool> onBackPressed() async {
    if (_selectedTab == 0) {
      showAlertDialouge();
    } else {
      _changeTab(0);
      _homeController.navListener.sink.add(0);
    }

    return Future.value(false);
  }

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  void showAlertDialouge() {
    showDialog(
        barrierColor: Colors.white.withOpacity(0.1),
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12)),
              title: const Text('Are you sure you want to exit ??'),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No')),
                TextButton(
                    onPressed: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    child: const Text('Yes'))
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    _selectedTab = widget.initPageNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackPressed,
        child: Scaffold(
          body: items[_selectedTab],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: bgColor,
            elevation: 0,
            currentIndex: _selectedTab,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: GoogleFonts.nunito(fontSize: 12),
            unselectedLabelStyle: GoogleFonts.nunito(fontSize: 12),
            onTap: (index) => _changeTab(index),
            selectedItemColor: textColor,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Dashboard"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.fastfood_outlined), label: "Recipes"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: "History"),
            ],
          ),
        ));
  }
}
