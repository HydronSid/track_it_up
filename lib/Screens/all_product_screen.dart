import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_it_up/Utils/appcolors.dart';
import 'package:track_it_up/Utils/common_functions.dart';

import 'product_detail.dart';
import '../Models/product_model.dart';

class AllProductScreen extends StatefulWidget {
  final bool isAppBar;
  const AllProductScreen({super.key, required this.isAppBar});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: blackColor),
          centerTitle: true,
          title: Text(
            "Foods",
            style: GoogleFonts.nunito(
                color: accentColor, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: widget.isAppBar,
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
                      borderSide:
                          const BorderSide(color: accentColor, width: 1)),
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
                        var product = searchResultList[index];
                        return InkWell(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                          mealType: "",
                                          productModel: product,
                                          action: "view",
                                        )));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Hero(
                                  tag: product.id!,
                                  child: Image.asset(
                                    product.image!,
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
                                product.name!,
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
      ),
    );
  }
}
