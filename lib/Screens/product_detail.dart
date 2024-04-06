import 'package:flutter/material.dart';
import 'package:track_it_up/Screens/product_model.dart';
import 'package:track_it_up/Utils/appcolors.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              Hero(
                  tag: productModel.id!,
                  child: Image.asset(
                    productModel.image!,
                    height: size.height * 0.5,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  )),
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
                  )))
            ],
          )
        ],
      )),
    );
  }
}
