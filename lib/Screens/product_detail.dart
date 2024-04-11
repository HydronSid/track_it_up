import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:track_it_up/Models/product_model.dart';
import 'package:track_it_up/Utils/appcolors.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: productModel.id!,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(400),
                            bottomRight: Radius.circular(800)),
                        child: Image.asset(
                          productModel.image!,
                          height: size.height * 0.6,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 15,
                        left: 15,
                        child: SafeArea(
                            child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: blackColor),
                              color: whiteColor,
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: blackColor,
                              size: 20.0,
                            ),
                          ),
                        ))),
                    Positioned(
                        top: 15,
                        right: 15,
                        child: SafeArea(
                            child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.zero,
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: productModel.foodtype! == "Veg"
                                      ? Colors.green
                                      : Colors.red),
                              child: Text(
                                productModel.foodtype!.toUpperCase(),
                                style: GoogleFonts.nunito(
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold),
                              )),
                        ))),
                    Positioned(
                        bottom: 0,
                        right: 10,
                        child: Text(
                          "Nutritional value\nper 50 grams",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              color: whiteColor, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel.name!,
                        style: GoogleFonts.nunito(
                            color: whiteColor,
                            fontSize: 20,
                            letterSpacing: 1.5),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Protein",
                                    style: GoogleFonts.nunito(
                                        color: blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${productModel.protein!} gms",
                                    style: GoogleFonts.nunito(
                                        color: blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              LinearPercentIndicator(
                                restartAnimation: false,
                                animation: true,
                                fillColor: Colors.transparent,
                                animateFromLastPercent: true,
                                animationDuration: 1000,
                                width: size.width * 0.8,
                                lineHeight: 10.0,
                                percent: ((double.parse(productModel.protein!) /
                                            30) *
                                        100) /
                                    100,
                                backgroundColor: Colors.grey,
                                barRadius: const Radius.circular(16),
                                progressColor:
                                    const Color.fromARGB(255, 59, 82, 255),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Fats",
                                    style: GoogleFonts.nunito(
                                        color: blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${productModel.fats!} gms",
                                    style: GoogleFonts.nunito(
                                        color: blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              LinearPercentIndicator(
                                restartAnimation: false,
                                animation: true,
                                fillColor: Colors.transparent,
                                animateFromLastPercent: true,
                                animationDuration: 1000,
                                width: size.width * 0.8,
                                lineHeight: 10.0,
                                percent:
                                    ((double.parse(productModel.fats!) / 30) *
                                            100) /
                                        100,
                                backgroundColor: Colors.grey,
                                barRadius: const Radius.circular(16),
                                progressColor:
                                    const Color.fromARGB(255, 59, 82, 255),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Calories",
                                    style: GoogleFonts.nunito(
                                        color: blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${productModel.calories!} gms",
                                    style: GoogleFonts.nunito(
                                        color: blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              LinearPercentIndicator(
                                restartAnimation: false,
                                animation: true,
                                fillColor: Colors.transparent,
                                animateFromLastPercent: true,
                                animationDuration: 1000,
                                width: size.width * 0.8,
                                lineHeight: 10.0,
                                percent:
                                    ((double.parse(productModel.calories!) /
                                                300) *
                                            100) /
                                        100,
                                backgroundColor: Colors.grey,
                                barRadius: const Radius.circular(16),
                                progressColor:
                                    const Color.fromARGB(255, 59, 82, 255),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Carbohydrate",
                                    style: GoogleFonts.nunito(
                                        color: blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${productModel.carbohydrate!} gms",
                                    style: GoogleFonts.nunito(
                                        color: blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              LinearPercentIndicator(
                                restartAnimation: false,
                                animation: true,
                                fillColor: Colors.transparent,
                                animateFromLastPercent: true,
                                animationDuration: 1000,
                                width: size.width * 0.8,
                                lineHeight: 10.0,
                                percent:
                                    ((double.parse(productModel.carbohydrate!) /
                                                20) *
                                            100) /
                                        100,
                                backgroundColor: Colors.grey,
                                barRadius: const Radius.circular(16),
                                progressColor:
                                    const Color.fromARGB(255, 59, 82, 255),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )
              ],
            )),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
                width: size.width * 0.6,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: whiteColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Add Food",
                          style: GoogleFonts.nunito(
                              color: whiteColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))),
          )
        ],
      ),
    );
  }
}
