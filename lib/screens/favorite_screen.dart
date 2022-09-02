import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared_preferences/pref_controller.dart';
import '../utils/helpers.dart';
import '../constants/fonts.dart';
import '../api/api_response.dart';
import '../constants/colors.dart';
import '../widgets/loading.dart';
import '../widgets/no_data.dart';
import '../widgets/view_details.dart';
import '../getX/favorite-products_getX.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('favorite'.tr)),
      body: GetX<FavoriteProductsGetX>(
        initState: (state) {
          state.controller!.getFavoriteProductsData();
        },
        builder: (controller) {
          if (FavoriteProductsGetX.to.loading.isTrue) {
            return const Loading();
          }
          return listFavoriteProducts();
        },
      ),
    );
  }

  Widget listFavoriteProducts() {
    if (FavoriteProductsGetX.to.favoriteProducts!.data!.isNotEmpty) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          childAspectRatio: 190 / 272,
        ),
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
        itemCount: FavoriteProductsGetX.to.favoriteProducts!.data!.length,
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
                  data: PrefController().language == 'en'
                      ? FavoriteProductsGetX
                          .to.favoriteProducts!.data![index].nameEn
                      : FavoriteProductsGetX
                          .to.favoriteProducts!.data![index].nameAr,
                  fontSize: 18,
                  color: ColorsApp.black,
                  fontFamily: FontsApp.fontMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                priceProduct(index),
                RatingBarIndicator(
                  itemSize: 18,
                  rating: double.parse(FavoriteProductsGetX
                      .to.favoriteProducts!.data![index].overalRate),
                  itemBuilder: (context, index) =>
                      const Icon(Icons.star, color: Colors.yellowAccent),
                ),
              ],
            ),
          );
        },
      );
    }
    return const NoData();
  }

  Widget imageProduct(int index) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: Image(
            image: NetworkImage(
              FavoriteProductsGetX.to.favoriteProducts!.data![index].imageUrl,
            ),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 180,
          ),
        ),
        IconButton(
          onPressed: () => addFavorite(index),
          icon: const Icon(
            Icons.favorite,
            color: ColorsApp.red,
            size: 28,
          ),
          padding: EdgeInsetsDirectional.zero,
        ),
      ],
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
            fontFamily: FontsApp.fontMedium,
            color: ColorsApp.green,
          ),
          const SizedBox(width: 10),
          ViewDetails(
            data: FavoriteProductsGetX.to.favoriteProducts!.data![index].price,
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
      data: FavoriteProductsGetX.to.favoriteProducts!.data![index].price,
      fontFamily: FontsApp.fontMedium,
      color: ColorsApp.green,
      fontSize: 16,
    );
  }

  void addFavorite(int index) async {
    ApiResponse apiResponse = await FavoriteProductsGetX.to
        .postFavoriteProductsData(
            id: FavoriteProductsGetX.to.favoriteProducts!.data![index].id
                .toString());
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
  }
}
