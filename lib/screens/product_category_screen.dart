import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:smart_store/getX/product_category_getX.dart';

import '../constants/routes.dart';
import '../getX/product_details_getX.dart';
import '../widgets/view_details.dart';

class ProductCategoryScreen extends StatefulWidget {
  const ProductCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  final ProductDetailsGetX _productDetails = Get.put(ProductDetailsGetX());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        titleTextStyle: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        centerTitle: true,
        title: const Text('Product_Category'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: GetX<ProductCategoryGetX>(
        initState: (state) {
          state.controller!.getProductCategoryData();
        },
        builder: (controller) {
          if (ProductCategoryGetX.to.loading.isTrue) {
            const Center(child: CircularProgressIndicator());
          }
          return listProduct();
        },
      ),
    );
  }

  Widget listProduct() {
    if (ProductCategoryGetX.to.productCategory != null) {
      return GridView.builder(
        padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 4 / 5.7,
        ),
        itemCount: ProductCategoryGetX.to.productCategory!.data!.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                _productDetails.id.value =
                    ProductCategoryGetX.to.productCategory!.data![index].id;
              });
              Navigator.pushNamed(context, productDetailsScreen);
            },
            child: Container(
              alignment: AlignmentDirectional.topStart,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  imageProduct(index),
                  const SizedBox(height: 5),
                  nameProduct(index),
                  const SizedBox(height: 3),
                  priceProduct(index),
                  const SizedBox(height: 3),
                  rating(index),
                ],
              ),
            ),
          );
        },
      );
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget imageProduct(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image(
        image: NetworkImage(
          ProductCategoryGetX.to.productCategory!.data![index].imageUrl,
        ),
        fit: BoxFit.fitHeight,
        width: double.infinity,
        height: 180,
      ),
    );
  }

  Widget nameProduct(int index) {
    return ViewDetails(
      data: ProductCategoryGetX.to.productCategory!.data![index].nameEn,
      fontSize: 20,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget priceProduct(int index) {
    if (ProductCategoryGetX.to.productCategory!.data![index].offerPrice !=
        null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ViewDetails(
            data:
                ProductCategoryGetX.to.productCategory!.data![index].offerPrice,
            fontSize: 16,
          ),
          const SizedBox(width: 10),
          ViewDetails(
            data: ProductCategoryGetX.to.productCategory!.data![index].price,
            fontSize: 13,
            decoration: TextDecoration.lineThrough,
            fontWeight: FontWeight.w500,
            height: 1.7,
            decorationThickness: 2,
          ),
        ],
      );
    }
    return ViewDetails(
      data: ProductCategoryGetX.to.productCategory!.data![index].price,
      fontSize: 16,
    );
  }

  Widget rating(int index) {
    return RatingBarIndicator(
      itemSize: 18,
      rating: double.parse(
          ProductCategoryGetX.to.productCategory!.data![index].overalRate),
      itemBuilder: (context, index) =>
          const Icon(Icons.star, color: Colors.yellowAccent),
    );
  }
}
