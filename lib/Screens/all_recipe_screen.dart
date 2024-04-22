import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_it_up/Utils/appcolors.dart';

class AllRecipeScreen extends StatefulWidget {
  const AllRecipeScreen({super.key});

  @override
  State<AllRecipeScreen> createState() => _AllRecipeScreenState();
}

class _AllRecipeScreenState extends State<AllRecipeScreen> {
  final TextEditingController _searchController = TextEditingController();

  List searchResultList = [];

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
          style: GoogleFonts.nunito(color: whiteColor),
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
              controller: _searchController,
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'Search Recipies...',
                hintStyle: GoogleFonts.nunito(color: whiteColor),
                prefixIcon: const Icon(
                  Icons.search,
                  color: whiteColor,
                ),
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 144, 142, 142))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: whiteColor, width: 1)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: whiteColor)),
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
                          // FocusScope.of(context).requestFocus(FocusNode());
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ProductDetailScreen(
                          //               mealType: "",
                          //               productModel: product,
                          //               action: "view",
                          //             )));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Hero(
                                tag: recipe.id!,
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
