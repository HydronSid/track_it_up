import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_it_up/Models/recipe_model.dart';
import 'package:track_it_up/Utils/appcolors.dart';

class RecipeDetailScreen extends StatelessWidget {
  final RecipeModel recipeModel;
  const RecipeDetailScreen({super.key, required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          backgroundColor: bgColor,
          body: SingleChildScrollView(
              child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: recipeModel.recipeId!,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(400),
                          bottomRight: Radius.circular(800)),
                      child: Image.asset(
                        recipeModel.image!,
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
                  // Positioned(
                  //     bottom: 0,
                  //     right: 10,
                  //     child: Text(
                  //       "Nutritional value\nper ${recipeModel.serving!}",
                  //       textAlign: TextAlign.center,
                  //       style: GoogleFonts.nunito(
                  //           color: whiteColor, fontWeight: FontWeight.bold),
                  //     ))
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
                      recipeModel.name!,
                      style: GoogleFonts.nunito(
                          color: whiteColor, fontSize: 20, letterSpacing: 1.5),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: whiteColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Ingredients",
                      style: GoogleFonts.nunito(
                          color: whiteColor, fontSize: 20, letterSpacing: 1.5),
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var data = recipeModel.ingredients![index];
                          return Text(
                            data,
                            style: GoogleFonts.nunito(
                                color: whiteColor,
                                fontSize: 15,
                                letterSpacing: 1.5),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: recipeModel.ingredients!.length),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: whiteColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Description",
                      style: GoogleFonts.nunito(
                          color: whiteColor, fontSize: 20, letterSpacing: 1.5),
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var data = recipeModel.description![index];
                          return Text(
                            data,
                            style: GoogleFonts.nunito(
                                color: whiteColor,
                                fontSize: 15,
                                letterSpacing: 1.5),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: recipeModel.description!.length)
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
