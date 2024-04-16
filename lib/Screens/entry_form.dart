import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_it_up/Database/database_helper.dart';
import 'package:track_it_up/Models/meal_model.dart';
import 'package:track_it_up/Utils/appcolors.dart';
import 'package:track_it_up/Utils/common_functions.dart';

import 'entry_form_two.dart';

class EntryFormCalulate extends StatefulWidget {
  const EntryFormCalulate({super.key});

  @override
  State<EntryFormCalulate> createState() => _EntryFormCalulateState();
}

class _EntryFormCalulateState extends State<EntryFormCalulate> {
  bool isLoading = false;
  @override
  void initState() {
    //MealOperations().getAllMealData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Enter what you have eaten so far.",
              style: GoogleFonts.nunito(
                  color: textColor, fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 1))
                            .asyncMap((_) => CommonFunctions()
                                .getMealByTypeDateUser("BreakFast")),
                        builder: (context, snapshot) {
                          return EntryFormOneHelper(
                            totalCal: snapshot.data == null
                                ? "0.0"
                                : CommonFunctions()
                                    .returnTotalMealCalories(snapshot.data!),
                            title: "BreakFast",
                            productList: snapshot.data ?? [],
                            state: snapshot.connectionState,
                          );
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 1))
                            .asyncMap((_) => CommonFunctions()
                                .getMealByTypeDateUser("Lunch")),
                        builder: (context, snapshot) {
                          return EntryFormOneHelper(
                            title: "Lunch",
                            productList: snapshot.data ?? [],
                            state: snapshot.connectionState,
                            totalCal: snapshot.data == null
                                ? "0.0"
                                : CommonFunctions()
                                    .returnTotalMealCalories(snapshot.data!),
                          );
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 1))
                            .asyncMap((_) => CommonFunctions()
                                .getMealByTypeDateUser("Dinner")),
                        builder: (context, snapshot) {
                          return EntryFormOneHelper(
                              totalCal: snapshot.data == null
                                  ? "0.0"
                                  : CommonFunctions()
                                      .returnTotalMealCalories(snapshot.data!),
                              title: "Dinner",
                              productList: snapshot.data ?? [],
                              state: snapshot.connectionState);
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 1))
                            .asyncMap((_) => CommonFunctions()
                                .getMealByTypeDateUser("Snacks")),
                        builder: (context, snapshot) {
                          return EntryFormOneHelper(
                              totalCal: snapshot.data == null
                                  ? "0.0"
                                  : CommonFunctions()
                                      .returnTotalMealCalories(snapshot.data!),
                              title: "Snacks",
                              productList: snapshot.data ?? [],
                              state: snapshot.connectionState);
                        }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class EntryFormOneHelper extends StatefulWidget {
  final String title, totalCal;
  final List<MealModel> productList;
  final ConnectionState state;

  const EntryFormOneHelper(
      {super.key,
      required this.title,
      required this.productList,
      required this.state,
      required this.totalCal});

  @override
  State<EntryFormOneHelper> createState() => _EntryFormOneHelperState();
}

class _EntryFormOneHelperState extends State<EntryFormOneHelper> {
  String totalCalEaten = "";
  double totCal = 0.0;

  @override
  void initState() {
    totCal = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      color: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: textColor)),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EntryFormTwoCalulate(
                                  mealType: widget.title,
                                ))),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: GoogleFonts.nunito(color: textColor),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${widget.totalCal} Cal eaten",
                              style: GoogleFonts.nunito(color: textColor),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.add,
                          color: whiteColor,
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    color: whiteColor,
                  ),
                  widget.state == ConnectionState.waiting
                      ? Container(
                          height: 15,
                          width: 15,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const CircularProgressIndicator(
                            color: textColor,
                          ),
                        )
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var product = widget.productList[index];

                            totCal += double.parse(product.totalCalories!);

                            var qnt = product.quantity!.split(" ");
                            double divideVal = 0.0;

                            divideVal = double.parse(product.totalCalories!) /
                                double.parse(qnt[0]);

                            totalCalEaten = totCal.toStringAsFixed(2);
                            return Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name!,
                                      style:
                                          GoogleFonts.nunito(color: textColor),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${divideVal.toStringAsFixed(2)} Cal x ${product.quantity!}",
                                      style:
                                          GoogleFonts.nunito(color: textColor),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  "${product.totalCalories!} Cal",
                                  style: GoogleFonts.nunito(color: textColor),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    DatabaseHelper.instance
                                        .deleteRecordFromTable(product.id!,
                                            DatabaseHelper.mealDBTableName);

                                    CommonFunctions.showSuccessSnackbar(
                                        "${product.name!} is removed from todays's ${widget.title}");
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: whiteColor,
                                  ),
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: whiteColor,
                            );
                          },
                          itemCount: widget.productList.length)
                ],
              ))
        ],
      ),
    );
  }
}
