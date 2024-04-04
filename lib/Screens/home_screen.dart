import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:track_it_up/Utils/appcolors.dart';
import 'package:track_it_up/Utils/fade_in_anime.dart';
import 'package:track_it_up/Utils/local_shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";
  DateTime today = DateTime.now();
  var format = DateFormat('hh:mm a');

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
                    const Icon(
                      Icons.settings,
                      color: textColor,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    _allDate.length,
                    (index) => dateContainer(
                      index: index,
                      dayData: _allDate,
                    ),
                  ),
                ),
              ),
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
