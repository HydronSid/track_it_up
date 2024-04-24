import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_it_up/Models/recipe_model.dart';
import 'package:track_it_up/Utils/appcolors.dart';

import 'recipe_detail_screen.dart';

class AllRecipeScreen extends StatefulWidget {
  const AllRecipeScreen({super.key});

  @override
  State<AllRecipeScreen> createState() => _AllRecipeScreenState();
}

class _AllRecipeScreenState extends State<AllRecipeScreen> {
  bool isLoading = true;

  final TextEditingController searchController = TextEditingController();

  List<RecipeModel> searchResultList = [], recipeList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getRecipies();
    });
    super.initState();
  }

  getRecipies() async {
    setState(() {
      isLoading = true;
    });

    searchController.addListener(onSearchChanged);

    String responce =
        await rootBundle.loadString('assets/images/recipies/allrecipies.json');
    List<dynamic> extractedData = await json.decode(responce);

    recipeList = extractedData.map((e) => RecipeModel.fromJson(e)).toList();

    searchResulList();
  }

  onSearchChanged() {
    searchResulList();
  }

  searchResulList() {
    List<RecipeModel> showResult = [];
    if (searchController.text != '') {
      showResult = recipeList.where((prod) {
        var orderno = prod.name!.toLowerCase();

        return orderno.contains(searchController.text.toLowerCase());
      }).toList();
    } else {
      showResult = List.from(recipeList);
    }

    searchResultList = showResult;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: whiteColor),
        centerTitle: true,
        title: Text(
          "Recipies",
          style: GoogleFonts.nunito(
              color: accentColor, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: bgColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
            child: TextFormField(
              style: GoogleFonts.nunito(color: whiteColor),
              controller: searchController,
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'Search Foods...',
                hintStyle: GoogleFonts.nunito(color: blackColor),
                prefixIcon: const Icon(
                  Icons.search,
                  color: accentColor,
                ),
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: blackColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: accentColor, width: 1)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: blackColor)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red)),
                filled: true,
                fillColor: bgColor,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          searchResultList.isEmpty
              ? Expanded(
                  child: Image.asset(
                    "assets/images/no_data_found.gif",
                    height: size.height * 0.45,
                  ),
                )
              : Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 15,
                      mainAxisExtent: 200,
                    ),
                    itemCount: searchResultList.length,
                    itemBuilder: (context, index) {
                      var recipe = searchResultList[index];
                      return InkWell(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecipeDetailScreen(
                                        recipeModel: recipe,
                                      )));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Hero(
                                tag: recipe.recipeId!,
                                child: Image.asset(
                                  recipe.image!,
                                  height: 170,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              recipe.name!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunito(
                                  color: textColor,
                                  fontSize: 16,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
