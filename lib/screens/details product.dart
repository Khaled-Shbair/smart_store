import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../api/api_response.dart';
import '../getX/rate_products_getX.dart';
import '../getX/favorite-products_getX.dart';
import '../models/home_model.dart';
import '../utils/helpers.dart';
import '../widgets/view_details.dart';

class DetailsProduct extends StatefulWidget {
  const DetailsProduct({Key? key, required this.product}) : super(key: key);
  final Products product;

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> with Helpers {
  double rate = 0;

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Column(
        children: [
          SizedBox(
            height: 275,
            child: Image(image: NetworkImage(widget.product.imageUrl)),
          ),
          details(),
        ],
      ),
    );
  }

  Widget details() {
    return Container(
      height: 440,
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
                const SizedBox(width: 20),
                rateProduct(),
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
            data: widget.product.nameEn,
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
              data: widget.product.infoEn,
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
    if (widget.product.offerPrice != null) {
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
          rating: rate == 0 ? double.parse(widget.product.overalRate) : rate,
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
      onPressed: () => addFavorite(),
      style: ElevatedButton.styleFrom(
        primary: widget.product.isFavorite ? Colors.red : Colors.blue,
        onPrimary: Colors.black,
        padding: EdgeInsetsDirectional.zero,
        minimumSize: const Size(35, 40),
      ),
      child: const Icon(Icons.favorite),
    );
  }

  Widget rateProduct() {
    return ElevatedButton(
      onPressed: () => showDialogs(),
      style: ElevatedButton.styleFrom(
        primary: widget.product.isFavorite ? Colors.red : Colors.blue,
        onPrimary: Colors.black,
        padding: EdgeInsetsDirectional.zero,
        minimumSize: const Size(35, 40),
      ),
      child: const Icon(Icons.star),
    );
  }

  SizedBox sizedBox(double height) => SizedBox(height: height);

  Future<void> showDialogs() {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const ViewDetails(
            data: 'Rate This Product',
            fontSize: 24,
          ),
          actions: [
            TextButton(
              onPressed: () {
                rateProducts();
                Navigator.pop(context);
              },
              child: const ViewDetails(
                data: 'OK',
                fontSize: 18,
              ),
            ),
          ],
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const ViewDetails(
                data: 'Please leave a star rating',
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              sizedBox(20),
              RatingBar.builder(
                itemSize: 46,
                minRating: 1,
                maxRating: 5,
                onRatingUpdate: (rating) {
                  setState(() {
                    rate = rating;
                  });
                },
                updateOnDrag: true,
                itemBuilder: (context, index) =>
                    const Icon(Icons.star, color: Colors.yellowAccent),
              ),
            ],
          ),
        );
      },
    );
  }

  void addFavorite() async {
    ApiResponse apiResponse = await FavoriteProductsGetX.to
        .postFavoriteProductsData(id: widget.product.id.toString());
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
  }

  void rateProducts() async {
    ApiResponse apiResponse = await RateProductsGetX.to.postRateProducts(
        id: widget.product.id.toString(), rate: rate.toString());
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
  }
}
