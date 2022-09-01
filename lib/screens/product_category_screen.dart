import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../constants/routes.dart';
import '../getX/product_category_getX.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../getX/product_details_getX.dart';
import '../widgets/loading.dart';
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
      backgroundColor: ColorsApp.scaffoldColor,
      appBar: AppBar(
        title: ViewDetails(
          data: AppLocalizations.of(context)!.product_category,
          fontFamily: FontsApp.fontBold,
          color: ColorsApp.green,
          fontSize: 24,
        ),
        iconTheme: const IconThemeData(color: ColorsApp.green),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: GetX<ProductCategoryGetX>(
        initState: (state) {
          state.controller!.getProductCategoryData();
        },
        builder: (controller) {
          if (_productDetails.loading.isTrue) {
            return const Loading();
          }
          return listProduct();
        },
      ),
    );
  }

  Widget imageProduct(int index) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Image(
        image: NetworkImage(
          ProductCategoryGetX.to.productCategory!.data![index].imageUrl,
        ),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 180,
      ),
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
            fontFamily: FontsApp.fontMedium,
            color: ColorsApp.green,
          ),
          const SizedBox(width: 10),
          ViewDetails(
            data: ProductCategoryGetX.to.productCategory!.data![index].price,
            decoration: TextDecoration.lineThrough,
            fontFamily: FontsApp.fontMedium,
            color: ColorsApp.gery,
            decorationThickness: 1,
            fontSize: 13,
            height: 1.7,
          ),
        ],
      );
    }
    return ViewDetails(
      data: ProductCategoryGetX.to.productCategory!.data![index].price,
      fontFamily: FontsApp.fontMedium,
      color: ColorsApp.green,
      fontSize: 16,
    );
  }

  Widget listProduct() {
    if (ProductCategoryGetX.to.productCategory != null) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, productDetailsScreen);
        },
        child: GridView.builder(
          shrinkWrap: true,
          primary: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 10,
            childAspectRatio: 190 / 264,
          ),
          itemCount: ProductCategoryGetX.to.productCategory!.data!.length,
          itemBuilder: (context, index) {
            return Container(
              alignment: AlignmentDirectional.topStart,
              decoration: BoxDecoration(
                color: ColorsApp.background.withAlpha(117),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  imageProduct(index),
                  const SizedBox(height: 5),
                  ViewDetails(
                    data: ProductCategoryGetX
                        .to.productCategory!.data![index].nameEn,
                    fontSize: 18,
                    color: ColorsApp.black,
                    fontFamily: FontsApp.fontMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  priceProduct(index),
                  const SizedBox(height: 3),
                  RatingBarIndicator(
                    itemSize: 18,
                    rating: double.parse(ProductCategoryGetX
                        .to.productCategory!.data![index].overalRate),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.yellowAccent,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    return const Loading();
  }
}
