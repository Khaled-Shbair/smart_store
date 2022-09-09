import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../shared_preferences/pref_controller.dart';
import '../../getX/favorite-products_getX.dart';
import '../../getX/product_details_getX.dart';
import '../../widgets/view_details.dart';
import 'package:flutter/material.dart';
import '../../api/api_response.dart';
import '../../widgets/no_data.dart';
import '../../widgets/loading.dart';
import '../../models/product.dart';
import '../../utils/helpers.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);
  final Products product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: GetX<ProductDetailsGetX>(
        builder: (controller) {
          if (ProductDetailsGetX.to.loading.isTrue) {
            const Loading();
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
    if (widget.product.images != null) {
      return GridView.builder(
        padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: (MediaQuery.of(context).size.width * 2) /
              (MediaQuery.of(context).size.height * 1.5),
        ),
        shrinkWrap: true,
        itemCount: widget.product.images!.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              alignment: AlignmentDirectional.center,
              fit: BoxFit.fitWidth,
              image: NetworkImage(
                widget.product.images![index].imageUrl,
              ),
            ),
          );
        },
      );
    } else {
      return const NoData();
    }
  }

  Widget details() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 40,
          start: 20,
          bottom: 30,
        ),
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
                ? widget.product.nameEn
                : widget.product.nameAr,
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
                  ? widget.product.infoEn
                  : widget.product.infoAr,
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
            data: widget.product.offerPrice,
            fontSize: 24,
            height: 1.3,
          ),
          const SizedBox(width: 10),
          ViewDetails(
            data: widget.product.price,
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
          data: widget.product.price,
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
          data: widget.product.quantity,
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
            widget.product.overalRate,
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
      onPressed: () async {
        setState(() {
          widget.product.isFavorite = !widget.product.isFavorite;
        });
        ApiResponse apiResponse = await FavoriteProductsGetX.to
            .postFavoriteProductsData(id: widget.product.id.toString());
        showSnackBar(message: apiResponse.message, error: !apiResponse.status);
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: widget.product.isFavorite ? Colors.red : Colors.white,
        padding: EdgeInsetsDirectional.zero,
        minimumSize: const Size(35, 40),
      ),
      child: const Icon(Icons.favorite),
    );
  }

  SizedBox sizedBox(double height) {
    return SizedBox(height: height);
  }
}
