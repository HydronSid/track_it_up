import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:track_it_up/Database/meal_operations.dart';
import 'package:track_it_up/Models/product_model.dart';
import 'package:track_it_up/Models/user_model.dart';
import 'package:track_it_up/Utils/appcolors.dart';
import 'package:track_it_up/Utils/common_functions.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel;
  final String action, mealType;

  const ProductDetailScreen(
      {super.key,
      required this.productModel,
      required this.action,
      required this.mealType});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  TextEditingController ctlQnty = TextEditingController();
  TextEditingController ctlServing = TextEditingController();
  String helper = "";
  double total = 0.0;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    ctlQnty.text = "1";
    String gram = widget.productModel.grams!;
    var help = gram.split(" ");

    total = 1.0 * double.parse(help[0]);

    if (widget.productModel.serving! == "1 g") {
      helper = "Gram (${widget.productModel.grams})";
    } else {
      helper = "${widget.productModel.serving!} (${widget.productModel.grams})";
    }
    ctlServing.text = helper;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
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
                        tag: widget.productModel.id!,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(400),
                              bottomRight: Radius.circular(800)),
                          child: Image.asset(
                            widget.productModel.image!,
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
                                    color:
                                        widget.productModel.foodtype! == "Veg"
                                            ? Colors.green
                                            : Colors.red),
                                child: Text(
                                  widget.productModel.foodtype!.toUpperCase(),
                                  style: GoogleFonts.nunito(
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold),
                                )),
                          ))),
                      Positioned(
                          bottom: 0,
                          right: 10,
                          child: Text(
                            "Nutritional value\nper ${widget.productModel.serving!}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                                color: blackColor, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productModel.name!,
                          style: GoogleFonts.nunito(
                              color: accentColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: whiteColor,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: borderColor, width: 2),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
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
                                      "${widget.productModel.calories!} g",
                                      style: GoogleFonts.nunito(
                                          color: accentColor,
                                          fontSize: 14,
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
                                  // progressColor:
                                  //     const Color.fromARGB(255, 59, 82, 255),
                                  progressColor: accentColor,
                                  backgroundColor: greyColor,
                                  animateFromLastPercent: true,
                                  animationDuration: 1000,
                                  width: size.width * 0.8,
                                  lineHeight: 10.0,
                                  percent: ((double.parse(widget
                                                  .productModel.calories!) /
                                              320) *
                                          100) /
                                      100,
                                  barRadius: const Radius.circular(16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: whiteColor,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: borderColor, width: 2),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
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
                                      "${widget.productModel.protein!} g",
                                      style: GoogleFonts.nunito(
                                          color: accentColor,
                                          fontSize: 14,
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
                                  // progressColor:
                                  //     const Color.fromARGB(255, 59, 82, 255),
                                  progressColor: accentColor,
                                  backgroundColor: greyColor,
                                  animateFromLastPercent: true,
                                  animationDuration: 1000,
                                  width: size.width * 0.8,
                                  lineHeight: 10.0,
                                  percent: ((double.parse(widget
                                                  .productModel.protein!) /
                                              320) *
                                          100) /
                                      100,
                                  barRadius: const Radius.circular(16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: whiteColor,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: borderColor, width: 2),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
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
                                      "${widget.productModel.carbohydrate!} g",
                                      style: GoogleFonts.nunito(
                                          color: accentColor,
                                          fontSize: 14,
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
                                  // progressColor:
                                  //     const Color.fromARGB(255, 59, 82, 255),
                                  progressColor: accentColor,
                                  backgroundColor: greyColor,
                                  animateFromLastPercent: true,
                                  animationDuration: 1000,
                                  width: size.width * 0.8,
                                  lineHeight: 10.0,
                                  percent: ((double.parse(widget
                                                  .productModel.carbohydrate!) /
                                              320) *
                                          100) /
                                      100,
                                  barRadius: const Radius.circular(16),
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
            widget.action == "view"
                ? const SizedBox()
                : Card(
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: textColor),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: TextFormField(
                                    cursorColor: textColor,
                                    maxLength: 3,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    style: GoogleFonts.nunito(color: textColor),
                                    controller: ctlQnty,
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        value = "0";
                                      }
                                      String gram = widget.productModel.grams!;
                                      var help = gram.split(" ");

                                      total = double.parse(value) *
                                          double.parse(help[0]);

                                      setState(() {});
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Required";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      errorStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5),
                                      fillColor: whiteColor,
                                      filled: true,
                                      counterText: "",
                                      label: Text("Quality",
                                          style: GoogleFonts.nunito(
                                              color: blackColor,
                                              fontWeight: FontWeight.bold)),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            const BorderSide(color: blackColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: accentColor, width: 2)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: blackColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: Colors.red)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    cursorColor: accentColor,
                                    maxLength: 3,
                                    textAlign: TextAlign.start,
                                    readOnly: true,
                                    keyboardType: TextInputType.number,
                                    style: GoogleFonts.nunito(color: textColor),
                                    controller: ctlServing,
                                    onChanged: (value) {},
                                    validator: (value) {
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      fillColor: whiteColor,
                                      filled: true,
                                      counterText: "",
                                      label: Text("Serving type",
                                          style: GoogleFonts.nunito(
                                              color: blackColor,
                                              fontWeight: FontWeight.bold)),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            const BorderSide(color: blackColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: blackColor, width: 2)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: blackColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              color: Colors.red)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total",
                                      style: GoogleFonts.nunito(
                                          color: accentColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${total.toStringAsFixed(2)} g",
                                      style: GoogleFonts.nunito(
                                          color: blackColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                SizedBox(
                                    width: size.width * 0.6,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25))),
                                        onPressed: () async {
                                          final isValid =
                                              _formKey.currentState!.validate();

                                          if (!isValid) {
                                            return;
                                          }

                                          UserModel userModel =
                                              await CommonFunctions().getUser();

                                          double totalCal = double.parse(widget
                                                  .productModel.calories!) *
                                              double.parse(ctlQnty.text);

                                          double totalProtein = double.parse(
                                                  widget
                                                      .productModel.protein!) *
                                              double.parse(ctlQnty.text);

                                          double totalCarbohydrate =
                                              double.parse(widget.productModel
                                                      .carbohydrate!) *
                                                  double.parse(ctlQnty.text);

                                          MealOperations().insertingMeal(
                                            prodId: widget.productModel.id!,
                                            name: widget.productModel.name!,
                                            quantity: ctlQnty.text,
                                            totalCalories:
                                                totalCal.toStringAsFixed(2),
                                            createdOn: CommonFunctions()
                                                .returnAppDateFormat(
                                                    DateTime.now()),
                                            updatedAt: CommonFunctions()
                                                .returnAppDateFormat(
                                                    DateTime.now()),
                                            mealType: widget.mealType,
                                            userId: userModel.id!,
                                            protein:
                                                totalProtein.toStringAsFixed(2),
                                            carbohydrate: totalCarbohydrate
                                                .toStringAsFixed(2),
                                            serving:
                                                widget.productModel.serving!,
                                            grams: total.toStringAsFixed(2),
                                          );
                                          Navigator.pop(context);
                                          CommonFunctions.showSuccessSnackbar(
                                              "${widget.productModel.name!} is added in todays's ${widget.mealType}");
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
