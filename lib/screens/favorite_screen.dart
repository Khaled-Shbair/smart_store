import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../getX/favorite-products_getX.dart';
import '../widgets/view_details.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return GetX<FavoriteProductsGetX>(
      initState: (state) {
        state.controller!.getFavoriteProductsData();
      },
      builder: (controller) {
        if (FavoriteProductsGetX.to.loading.isTrue) {
          return const Center(child: CircularProgressIndicator());
        }
        return listFavoriteProducts();
      },
    );
  }

  Widget listFavoriteProducts() {
    if (FavoriteProductsGetX.to.favoriteProducts != null) {
      return GridView.builder(
        padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 4 / 5.7,
        ),
        itemCount: FavoriteProductsGetX.to.favoriteProducts!.data!.length,
        itemBuilder: (context, index) {
          return Container(
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
          );
        },
      );
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(Icons.warning, size: 84, color: Colors.red),
          ViewDetails(
            data: 'No Data',
            fontSize: 30,
          ),
        ],
      ),
    );
  }

  Widget imageProduct(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image(
        image: NetworkImage(
          FavoriteProductsGetX.to.favoriteProducts!.data![index].imageUrl,
        ),
        fit: BoxFit.fitHeight,
        width: double.infinity,
        height: 180,
      ),
    );
  }

  Widget nameProduct(int index) {
    return ViewDetails(
      data: FavoriteProductsGetX.to.favoriteProducts!.data![index].nameEn,
      fontSize: 20,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget priceProduct(int index) {
    if (FavoriteProductsGetX.to.favoriteProducts!.data![index].offerPrice !=
        null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ViewDetails(
            data: FavoriteProductsGetX
                .to.favoriteProducts!.data![index].offerPrice,
            fontSize: 16,
          ),
          const SizedBox(width: 10),
          ViewDetails(
            data: FavoriteProductsGetX.to.favoriteProducts!.data![index].price,
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
      data: FavoriteProductsGetX.to.favoriteProducts!.data![index].price,
      fontSize: 16,
    );
  }

  Widget rating(int index) {
    return RatingBarIndicator(
      itemSize: 18,
      rating: double.parse(
          FavoriteProductsGetX.to.favoriteProducts!.data![index].overalRate),
      itemBuilder: (context, index) =>
          const Icon(Icons.star, color: Colors.yellowAccent),
    );
  }
}
