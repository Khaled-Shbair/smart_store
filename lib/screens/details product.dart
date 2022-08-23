import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smart_store/models/home_model.dart';

import '../models/home_model.dart';

class DetailsProduct extends StatefulWidget {
  const DetailsProduct({Key? key, required this.product}) : super(key: key);
  final Products product;

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
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

class _DetailsProductState extends State<DetailsProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          Container(
            child: Image(image: NetworkImage(widget.product.imageUrl)),
          ),
          details(),
        ],
      ),
    );
  }

  Widget rating() {
    return Row(
      children: [
        const Text(
          'Evaluation: ',
          style: TextStyle(
            fontSize: 26,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        RatingBarIndicator(
          itemSize: 22,
          rating: double.parse(widget.product.overalRate),
          itemBuilder: (context, index) =>
              const Icon(Icons.star, color: Colors.yellowAccent),
        ),
      ],
    );
  }

  Widget quantityProduct() {
    return Text(
      'quantity: ${widget.product.quantity}',
      style: const TextStyle(
        fontSize: 26,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget nameProduct() {
    return Row(
      children: [
        const Text(
          'Name: ',
          style: TextStyle(
            fontSize: 28,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          widget.product.nameEn,
          style: const TextStyle(
            fontSize: 28,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget infoProduct() {
    return Row(
      children: [
        const Text(
          'Info: ',
          maxLines: 3,
          style: TextStyle(
            fontSize: 22,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          widget.product.infoEn,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget priceProduct() {
    if (widget.product.offerPrice != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'offerPrice: ${widget.product.offerPrice}',
            style: const TextStyle(
              fontSize: 26,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            '${widget.product.price}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 24,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      );
    }
    return Text(
      'price: ${widget.product.price}',
      style: const TextStyle(
        fontSize: 20,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
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

  Widget details() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: ListView(
        padding: const EdgeInsetsDirectional.only(
          top: 30,
          start: 10,
          end: 10,
          bottom: 30,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          nameProduct(),
          infoProduct(),
          priceProduct(),
          quantityProduct(),
          rating(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              addToCart(),
              const SizedBox(width: 20),
              addToFavorite(),
            ],
          ),

          SizedBox(
            height: 190,
          ),
        ],
      ),
    );
  }
}
