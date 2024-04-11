import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_it_up/Screens/splash_screen.dart';
import 'package:track_it_up/Utils/appcolors.dart';
import 'package:track_it_up/Utils/fade_in_anime.dart';
import 'package:track_it_up/Utils/local_shared_preferences.dart';

import 'entry_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";
  DateTime today = DateTime.now();
  var format = DateFormat('hh:mm a');
  PageController _ctlPageController = PageController();
  int currentIndex = 0;
  var openTime = "";
  int selectedDate = 0;
  int? selectedTime;
  String monthYear = "";
  final List _timeSlot = [];
  dynamic uptoDate;
  List _allDate = [];

  @override
  void initState() {
    nb.setStatusBarColor(bgColor);
    _ctlPageController = PageController(initialPage: 0, viewportFraction: 0.75);

    initData();
    super.initState();
  }

  initData() async {
    userName = await LocalPreferences().getUserName() ?? "";
    selectedDate = 0;
    selectedTime = null;
    monthYear = "";
    _allDate.clear();
    _timeSlot.clear();

    var dada = '${months[DateTime.now().month - 1]} ${DateTime.now().year}';
    monthYear = dada;

    uptoDate = today.add(const Duration(days: 7));

    _allDate = getDaysInBetween(today, uptoDate);

    setState(() {});
  }

  changeSelectedIndexDate(
    var index,
  ) {
    selectedDate = index;
    setState(() {});
  }

  getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  List<String> daysInWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List months = [
    'Jan',
    'Feb',
    'Mar',
    'April',
    'May',
    'Jun',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

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
    var size = MediaQuery.of(context).size;
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
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome ,",
                          style: GoogleFonts.nunito(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          userName,
                          style: GoogleFonts.nunito(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
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
                children: [
                  Text(
                    "Track your Nutrition,",
                    style: GoogleFonts.nunito(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EntryFormCalulate())),
                      child: const Text("Go"))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      TrackerWidget(
                        title: "Calories",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TrackerWidget(
                        title: "Protein",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TrackerWidget(
                        title: "Carbs",
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  dateContainer({
    int? index,
    List? dayData,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: GestureDetector(
        onTap: () {
          changeSelectedIndexDate(
            index,
          );
        },
        child: Container(
          padding: const EdgeInsets.only(left: 10, top: 3, bottom: 3),
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(
                width: selectedDate == index ? 2.5 : 0.5,
                color: selectedDate == index ? accentColor : blackColor),
            color: accentColor.withOpacity(0.15),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                daysInWeek[dayData![index!].weekday - 1],
                style: GoogleFonts.nunito(
                  color: selectedDate == index ? accentColor : textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dayData[index].day.toString(),
                style: GoogleFonts.nunito(
                  color: selectedDate == index ? accentColor : textColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                "${months[dayData[index].month - 1]}",
                style: GoogleFonts.nunito(
                  color: selectedDate == index ? accentColor : textColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class TrackerWidget extends StatelessWidget {
  final String title;
  const TrackerWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 74, 77, 95),
      ),
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.nunito(color: textColor, fontSize: 18),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              CircularPercentIndicator(
                restartAnimation: false,
                animateFromLastPercent: true,
                animation: true,
                animationDuration: 1000,
                radius: 55.0,
                lineWidth: 10.0,
                percent: 0.8,
                center: Text(
                  "2500\nRemaining",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                      color: textColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: bgColor,
                progressColor: accentColor,
              ),
              const Spacer(),
              Row(
                children: [
                  Column(
                    children: const [
                      Icon(
                        Icons.golf_course_sharp,
                        color: whiteColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Icon(
                        Icons.golf_course_sharp,
                        color: whiteColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Base Goal",
                            style: GoogleFonts.nunito(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          Text(
                            "2550",
                            style: GoogleFonts.nunito(
                                color: textColor, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            "Consumed",
                            style: GoogleFonts.nunito(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          Text(
                            "0",
                            style: GoogleFonts.nunito(
                                color: textColor, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
