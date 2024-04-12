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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)).asyncMap(
                      (_) =>
                          CommonFunctions().getMealByTypeDateUser("BreakFast")),
                  builder: (context, snapshot) {
                    return EntryFormOneHelper(
                      title: "BreakFast",
                      totalCalEaten: "130",
                      productList: snapshot.data ?? [],
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)).asyncMap(
                      (_) => CommonFunctions().getMealByTypeDateUser("Lunch")),
                  builder: (context, snapshot) {
                    return EntryFormOneHelper(
                      title: "Lunch",
                      totalCalEaten: "130",
                      productList: snapshot.data ?? [],
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)).asyncMap(
                      (_) => CommonFunctions().getMealByTypeDateUser("Dinner")),
                  builder: (context, snapshot) {
                    return EntryFormOneHelper(
                      title: "Dinner",
                      totalCalEaten: "130",
                      productList: snapshot.data ?? [],
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)).asyncMap(
                      (_) => CommonFunctions().getMealByTypeDateUser("Snacks")),
                  builder: (context, snapshot) {
                    return EntryFormOneHelper(
                      title: "Snacks",
                      totalCalEaten: "130",
                      productList: snapshot.data ?? [],
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EntryFormOneHelper extends StatelessWidget {
  final String title, totalCalEaten;
  final List<MealModel> productList;

  const EntryFormOneHelper(
      {super.key,
      required this.title,
      required this.totalCalEaten,
      required this.productList});

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
                                  mealType: title,
                                ))),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.nunito(color: textColor),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              totalCalEaten,
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
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var product = productList[index];
                        return Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name!,
                                  style: GoogleFonts.nunito(color: textColor),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${product.quantity!} g",
                                  style: GoogleFonts.nunito(color: textColor),
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
                                DatabaseHelper.instance.deleteRecordFromTable(
                                    product.id!,
                                    DatabaseHelper.mealDBTableName);

                                CommonFunctions.showSuccessSnackbar(
                                    "${product.name!} is removed from todays's $title");
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
                      itemCount: productList.length)
                ],
              ))
        ],
      ),
    );
  }
}
