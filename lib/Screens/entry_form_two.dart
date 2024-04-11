import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_it_up/Utils/appcolors.dart';
import 'package:track_it_up/Utils/common_functions.dart';

import 'product_model.dart';

class EntryFormTwoCalulate extends StatefulWidget {
  const EntryFormTwoCalulate({super.key});

  @override
  State<EntryFormTwoCalulate> createState() => _EntryFormTwoCalulateState();
}

class _EntryFormTwoCalulateState extends State<EntryFormTwoCalulate> {
  bool isLoading = true;

  List<ProductModel> productList = [], searchResultList = [];

  TextEditingController searchController = TextEditingController();

  getProductData() async {
    setState(() {
      isLoading = true;
    });

    searchController.addListener(onSearchChanged);

    productList = await CommonFunctions().getProductList();

    searchResulList();
  }

  onSearchChanged() {
    searchResulList();
  }

  searchResulList() {
    List<ProductModel> showResult = [];
    if (searchController.text != '') {
      showResult = productList.where((prod) {
        var orderno = prod.name!.toLowerCase();

        return orderno.contains(searchController.text.toLowerCase());
      }).toList();
    } else {
      showResult = List.from(productList);
    }

    searchResultList = showResult;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getProductData();
    super.initState();
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
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
              child: TextFormField(
                style: GoogleFonts.nunito(color: whiteColor),
                controller: searchController,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Search Food...',
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
                      borderSide:
                          const BorderSide(color: whiteColor, width: 1)),
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
              height: 15,
            ),
            searchResultList.isEmpty
                ? Expanded(
                    child: Image.asset(
                      "assets/images/no_data_found.gif",
                      height: size.height * 0.45,
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          var product = searchResultList[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name!,
                                        style: GoogleFonts.nunito(
                                            color: textColor,
                                            fontSize: 16,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "1 g",
                                        style: GoogleFonts.nunito(
                                            color: textColor,
                                            fontSize: 14,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "3 Cal",
                                  style: GoogleFonts.nunito(
                                      color: textColor,
                                      fontSize: 16,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.add,
                                  color: whiteColor,
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                        itemCount: searchResultList.length)),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
