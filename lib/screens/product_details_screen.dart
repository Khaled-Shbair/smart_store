import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared_preferences/pref_controller.dart';
import '../getX/product_details_getX.dart';
import '../widgets/view_details.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

PreferredSizeWidget appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
    ),
  );
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: GetX<ProductDetailsGetX>(
        initState: (state) {
          state.controller!.getProductDetailsData();
        },
        builder: (controller) {
          if (ProductDetailsGetX.to.loading.isTrue) {
            const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Expanded(
                child: imageProduct(),
              ),
              details(),
            ],
          );
        },
      ),
    );
  }

  Widget imageProduct() {
    return GridView.builder(
      padding: const EdgeInsetsDirectional.only(
        start: 20,
        end: 20,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: .4 / .5,
      ),
      shrinkWrap: true,
      itemCount: ProductDetailsGetX.to.productDetails!.data!.images!.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
            alignment: AlignmentDirectional.center,
            fit: BoxFit.fitWidth,
            image: NetworkImage(
              ProductDetailsGetX
                  .to.productDetails!.data!.images![index].imageUrl,
            ),
          ),
        );
      },
    );
  }

  Widget details() {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsetsDirectional.only(top: 40, start: 20, bottom: 30),
        child: Column(
          children: [
            nameProduct(),
            sizedBox(10),
            infoProduct(),
            sizedBox(10),
            priceProduct(),
            sizedBox(10),
            quantityProduct(),
            sizedBox(10),
            rating(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                addToCart(),
                const SizedBox(width: 20),
                addToFavorite(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget nameProduct() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ViewDetails(
          data: 'Name: ',
          color: Colors.black,
        ),
        Expanded(
          child: ViewDetails(
            data: PrefController().language == 'en'
                ? ProductDetailsGetX.to.productDetails!.data!.nameEn
                : ProductDetailsGetX.to.productDetails!.data!.nameAr,
            fontSize: 24,
            height: 1.3,
          ),
        ),
      ],
    );
  }

  Widget infoProduct() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ViewDetails(
          data: 'Info: ',
          color: Colors.black,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ViewDetails(
              data: PrefController().language == 'en'
                  ? ProductDetailsGetX.to.productDetails!.data!.infoEn
                  : ProductDetailsGetX.to.productDetails!.data!.infoAr,
              fontSize: 24,
              height: 1.3,
              maxLines: 3,
            ),
          ),
        ),
      ],
    );
  }

  Widget priceProduct() {
    if (ProductDetailsGetX.to.productDetails!.data!.offerPrice != null) {
      return Row(
        children: [
          const ViewDetails(
            data: 'Offer Price: ',
            color: Colors.black,
          ),
          ViewDetails(
            data: ProductDetailsGetX.to.productDetails!.data!.offerPrice,
            fontSize: 24,
            height: 1.3,
          ),
          const SizedBox(width: 10),
          ViewDetails(
            data: ProductDetailsGetX.to.productDetails!.data!.price,
            fontWeight: FontWeight.w500,
            fontSize: 18,
            height: 1.5,
            decoration: TextDecoration.lineThrough,
            decorationThickness: 2.5,
          ),
        ],
      );
    }
    return Row(
      children: [
        const ViewDetails(
          data: 'Price: ',
          color: Colors.black,
        ),
        ViewDetails(
          data: ProductDetailsGetX.to.productDetails!.data!.price,
          fontSize: 24,
          height: 1.3,
        ),
      ],
    );
  }

  Widget quantityProduct() {
    return Row(
      children: [
        const ViewDetails(
          data: 'Quantity: ',
          color: Colors.black,
        ),
        ViewDetails(
          data: ProductDetailsGetX.to.productDetails!.data!.quantity,
          fontSize: 24,
          height: 1.3,
        ),
      ],
    );
  }

  Widget rating() {
    return Row(
      children: [
        const ViewDetails(
          data: 'Evaluation: ',
          color: Colors.black,
        ),
        RatingBarIndicator(
          itemSize: 22,
          rating: double.parse(
            ProductDetailsGetX.to.productDetails!.data!.overalRate,
          ),
          itemBuilder: (context, index) =>
              const Icon(Icons.star, color: Colors.yellowAccent),
        ),
      ],
    );
  }

  Widget addToCart() {
    return ElevatedButton(onPressed: () {}, child: const Text('Add to Cart'));
  }

  Widget addToFavorite() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        onPrimary: Colors.black,
        padding: EdgeInsetsDirectional.zero,
        minimumSize: const Size(35, 40),
      ),
      child: const Icon(Icons.favorite),
    );
  }

  SizedBox sizedBox(double height) => SizedBox(height: height);
}
