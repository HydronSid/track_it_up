import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_it_up/Screens/product_model.dart';
import 'package:track_it_up/Utils/appcolors.dart';

import 'entry_form_two.dart';

class EntryFormCalulate extends StatefulWidget {
  const EntryFormCalulate({super.key});

  @override
  State<EntryFormCalulate> createState() => _EntryFormCalulateState();
}

class _EntryFormCalulateState extends State<EntryFormCalulate> {
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
            const EntryFormOneHelper(
              title: "BreakFast",
              totalCalEaten: "130",
              productList: [],
            ),
            const SizedBox(
              height: 15,
            ),
            const EntryFormOneHelper(
              title: "Lunch",
              totalCalEaten: "130",
              productList: [],
            ),
            const SizedBox(
              height: 15,
            ),
            const EntryFormOneHelper(
              title: "Dinner",
              totalCalEaten: "130",
              productList: [],
            ),
            const SizedBox(
              height: 15,
            ),
            const EntryFormOneHelper(
              title: "Snacks",
              totalCalEaten: "130",
              productList: [],
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

class EntryFormOneHelper extends StatelessWidget {
  final String title, totalCalEaten;
  final List<ProductModel> productList;

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
                            builder: (context) =>
                                const EntryFormTwoCalulate())),
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
                                  height: 10,
                                ),
                                Text(
                                  product.quantity!,
                                  style: GoogleFonts.nunito(color: textColor),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              "1 Cal",
                              style: GoogleFonts.nunito(color: textColor),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.close,
                                color: whiteColor,
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
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
