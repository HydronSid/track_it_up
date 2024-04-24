import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_it_up/Models/user_model.dart';
import 'package:track_it_up/Screens/splash_screen.dart';
import 'package:track_it_up/Utils/appcolors.dart';
import 'package:track_it_up/Utils/common_functions.dart';
import 'package:track_it_up/Utils/fade_in_anime.dart';

import 'entry_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";
  PageController _ctlPageController = PageController();
  int currentIndex = 0;

  // List helper = [];
  UserModel userModel = UserModel();

  @override
  void initState() {
    nb.setStatusBarColor(bgColor);
    _ctlPageController = PageController(initialPage: 0, viewportFraction: 0.75);

    initData();
    super.initState();
  }

  initData() async {
    userModel = await CommonFunctions().getUser();
    userName = userModel.name!;
    setState(() {});
  }

  List title = [
    'Calories',
    'Protein',
    'Carbs',
  ];

  @override
  void dispose() {
    _ctlPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FadeInWidget(
                duration: const Duration(microseconds: 400),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Track It Up",
                    style: GoogleFonts.laila(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FadeInWidget(
                duration: const Duration(microseconds: 700),
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello , ",
                          style: GoogleFonts.nunito(
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "$userName 👋",
                          style: GoogleFonts.nunito(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        final preferences =
                            await SharedPreferences.getInstance();
                        await preferences.clear();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const SplashScreen()),
                            (Route<dynamic> route) => false);
                      },
                      child: const Icon(
                        Icons.logout_rounded,
                        color: textColor,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Track your Nutrition,",
                    style: GoogleFonts.nunito(
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EntryFormCalulate())),
                      child: Text(
                        "Go",
                        style: GoogleFonts.nunito(color: whiteColor),
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 1))
                          .asyncMap(
                              (_) => CommonFunctions().getAllTodayMealData()),
                      builder: (context, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? Column(
                                children: const [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Center(
                                      child: CircularProgressIndicator(
                                          color: accentColor)),
                                ],
                              )
                            : Column(
                                children: [
                                  TrackerWidget(
                                    title: "Calories",
                                    consumed: snapshot.data.isEmpty
                                        ? "0"
                                        : snapshot.data[0].toStringAsFixed(2),
                                    remaining: snapshot.data.isEmpty
                                        ? "0"
                                        : snapshot.data[3].toStringAsFixed(2),
                                    goal: userModel.requiredCal ?? "0",
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TrackerWidget(
                                    title: "Protein",
                                    consumed: snapshot.data.isEmpty
                                        ? "0"
                                        : snapshot.data[1].toStringAsFixed(2),
                                    remaining: snapshot.data.isEmpty
                                        ? "0"
                                        : snapshot.data[4].toStringAsFixed(2),
                                    goal: userModel.requiredProtein ?? "0",
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TrackerWidget(
                                    title: "Carbs",
                                    consumed: snapshot.data.isEmpty
                                        ? "0"
                                        : snapshot.data[2].toStringAsFixed(2),
                                    remaining: snapshot.data.isEmpty
                                        ? "0"
                                        : snapshot.data[5].toStringAsFixed(2),
                                    goal: userModel.requiredCarbs ?? "0",
                                  ),
                                ],
                              );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TrackerWidget extends StatelessWidget {
  final String title, goal, consumed, remaining;

  const TrackerWidget({
    super.key,
    required this.title,
    required this.consumed,
    required this.goal,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: whiteColor,
        ),
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.nunito(
                  color: blackColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircularPercentIndicator(
                  restartAnimation: false,
                  animateFromLastPercent: true,
                  animation: true,
                  animationDuration: 1000,
                  radius: 55.0,
                  lineWidth: 10.0,
                  percent: goal == "0"
                      ? 0.0
                      : double.parse(consumed) > double.parse(goal)
                          ? 1.0
                          : ((double.parse(consumed) / double.parse(goal)) *
                                  100) /
                              100,
                  center: Text(
                    "$remaining\nRemaining",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        color: accentColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: greyColor,
                  progressColor: accentColor,
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Base Goal :",
                          style: GoogleFonts.nunito(
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          title == "Calories" ? "$goal Cal" : "$goal g",
                          style: GoogleFonts.nunito(
                              color: textColor, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Consumed : ",
                          style: GoogleFonts.nunito(
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          title == "Calories" ? "$consumed Cal" : "$consumed g",
                          style: GoogleFonts.nunito(
                              color: textColor, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
