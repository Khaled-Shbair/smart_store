import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/helpers.dart';
import '../getX/home_getX.dart';
import '../constants/fonts.dart';
import '../widgets/loading.dart';
import '../api/api_response.dart';
import '../constants/colors.dart';
import '../constants/routes.dart';
import '../widgets/title_list.dart';
import '../widgets/view_details.dart';
import '../getX/rate_products_getX.dart';
import '../getX/favorite-products_getX.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Helpers {
  final HomeGetX _homeGetX = Get.put(HomeGetX());
  final RateProductsGetX rateProducts = Get.put(RateProductsGetX());
  final FavoriteProductsGetX favoriteProducts = Get.put(FavoriteProductsGetX());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.scaffoldColor,
      appBar: AppBar(
        title: const ViewDetails(
          data: 'Home',
          fontFamily: FontsApp.fontBold,
          color: ColorsApp.green,
          fontSize: 24,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: GetX<HomeGetX>(
        initState: (state) {
          state.controller!.getHomeData();
        },
        builder: (controller) {
          if (_homeGetX.loading.isTrue) {
            return const Loading();
          }
          return ListView(
            children: [
              carouselSlider(),
              listCategories(),
              listProduct(),
            ],
          );
        },
      ),
    );
  }

  Widget carouselSlider() {
    if (_homeGetX.homeModel != null) {
      return Container(
        margin: const EdgeInsetsDirectional.only(top: 20, bottom: 20),
        child: CarouselSlider(
          items: _homeGetX.homeModel!.data!.slider!.map((e) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                fit: BoxFit.cover,
                width: double.infinity,
                image: NetworkImage(e.imageUrl),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 250,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            viewportFraction: 0.8,
          ),
        ),
      );
    }
    return const Loading();
  }

  Widget listCategories() {
    if (_homeGetX.homeModel != null) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(
          bottom: 10,
          start: 10,
          end: 10,
        ),
        child: Column(
          children: [
            TitleList(
              title: 'Categories',
              onPressed: () {
                Navigator.pushNamed(context, categoryScreen);
              },
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 100,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _homeGetX.homeModel!.data!.category!.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return Container(
                    width: 65,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      color: ColorsApp.background.withAlpha(117),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Image(
                            image: NetworkImage(
                              _homeGetX
                                  .homeModel!.data!.category![index].imageUrl,
                            ),
                            height: 50,
                            width: 50,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ViewDetails(
                          data: _homeGetX
                              .homeModel!.data!.category![index].nameEn,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          textAlign: TextAlign.center,
                          fontFamily: FontsApp.fontMedium,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
    return const Loading();
  }

  Widget listProduct() {
    if (_homeGetX.homeModel != null) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
        child: Column(
          children: [
            TitleList(
              title: 'Products',
              onPressed: () {
                //TODO: later
                //  Navigator.pushNamed(context, );
              },
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              primary: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 190 / 264,
              ),
              itemCount: _homeGetX.homeModel!.data!.latestProducts!.length,
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
                        data: _homeGetX
                            .homeModel!.data!.latestProducts![index].nameEn,
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
                        rating: double.parse(_homeGetX.homeModel!.data!
                            .latestProducts![index].overalRate),
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
          ],
        ),
      );
    }
    return const Loading();
  }

  Widget imageProduct(int index) {
    if (_homeGetX.homeModel!.data!.latestProducts![index].offerPrice != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image(
              image: NetworkImage(
                _homeGetX.homeModel!.data!.latestProducts![index].imageUrl,
              ),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 180,
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.all(2),
            color: ColorsApp.red,
            child: const ViewDetails(
              data: 'Discount',
              fontFamily: FontsApp.fontBold,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: IconButton(
              onPressed: () {
                addFavorite(index);
                setState(() {
                  _homeGetX.homeModel!.data!.latestProducts![index].isFavorite =
                      !_homeGetX
                          .homeModel!.data!.latestProducts![index].isFavorite;
                });
              },
              icon: _homeGetX.homeModel!.data!.latestProducts![index].isFavorite
                  ? const Icon(
                      Icons.favorite,
                      color: ColorsApp.red,
                      size: 28,
                    )
                  : const Icon(
                      Icons.favorite_outline,
                      color: ColorsApp.red,
                      size: 28,
                    ),
              padding: EdgeInsetsDirectional.zero,
            ),
          ),
        ],
      );
    }
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
              _homeGetX.homeModel!.data!.latestProducts![index].imageUrl,
            ),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 180,
          ),
        ),
        IconButton(
          onPressed: () {
            addFavorite(index);
            setState(() {
              _homeGetX.homeModel!.data!.latestProducts![index].isFavorite =
                  !_homeGetX.homeModel!.data!.latestProducts![index].isFavorite;
            });
          },
          icon: _homeGetX.homeModel!.data!.latestProducts![index].isFavorite
              ? const Icon(
                  Icons.favorite,
                  color: ColorsApp.red,
                  size: 28,
                )
              : const Icon(
                  Icons.favorite_outline,
                  color: ColorsApp.red,
                  size: 28,
                ),
          padding: EdgeInsetsDirectional.zero,
        ),
      ],
    );
  }

  Widget priceProduct(int index) {
    if (_homeGetX.homeModel!.data!.latestProducts![index].offerPrice != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ViewDetails(
            data: _homeGetX.homeModel!.data!.latestProducts![index].offerPrice,
            fontSize: 16,
            fontFamily: FontsApp.fontMedium,
            color: ColorsApp.green,
          ),
          const SizedBox(width: 10),
          ViewDetails(
            data: _homeGetX.homeModel!.data!.famousProducts![index].price,
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
      data: _homeGetX.homeModel!.data!.latestProducts![index].price,
      fontFamily: FontsApp.fontMedium,
      color: ColorsApp.green,
      fontSize: 16,
    );
  }

  void addFavorite(int index) async {
    ApiResponse apiResponse = await favoriteProducts.postFavoriteProductsData(
        id: _homeGetX.homeModel!.data!.latestProducts![index].id.toString());
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
  }
}
/*
  Widget listProduct() {
    if (_homeGetX.homeModel != null) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
        child: Column(
          children: [
            TitleList(
              title: 'Products',
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              primary: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 190 / 264,
              ),
              itemCount: _homeGetX.homeModel!.data!.latestProducts!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      detailsProduct,
                      arguments:
                          _homeGetX.homeModel!.data!.latestProducts![index],
                    );
                  },
                  child: Container(
                    alignment: AlignmentDirectional.topStart,
                    decoration: BoxDecoration(
                      color: ColorsApp.backGroun.withAlpha(117),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        imageProduct(index),
                        const SizedBox(height: 5),
                        ViewDetails(
                          data: _homeGetX
                              .homeModel!.data!.latestProducts![index].nameEn,
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
                          rating: double.parse(_homeGetX.homeModel!.data!
                              .latestProducts![index].overalRate),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.yellowAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
    return const Loading();
  }

  Widget imageProduct(int index) {
    if (_homeGetX.homeModel!.data!.latestProducts![index].offerPrice != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image(
              image: NetworkImage(
                _homeGetX.homeModel!.data!.latestProducts![index].imageUrl,
              ),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 180,
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.all(2),
            color: ColorsApp.red,
            child: const ViewDetails(
              data: 'Discount',
              fontFamily: FontsApp.fontBold,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite,
                color: ColorsApp.red,
                size: 28,
              ),
              padding: EdgeInsetsDirectional.zero,
            ),
          ),
        ],
      );
    }
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
              _homeGetX.homeModel!.data!.latestProducts![index].imageUrl,
            ),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 180,
          ),
        ),
        IconButton(
          onPressed: () {},
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
    if (_homeGetX.homeModel!.data!.latestProducts![index].offerPrice != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ViewDetails(
            data: _homeGetX.homeModel!.data!.latestProducts![index].offerPrice,
            fontSize: 16,
            fontFamily: FontsApp.fontMedium,
            color: ColorsApp.green,
          ),
          const SizedBox(width: 10),
          ViewDetails(
            data: _homeGetX.homeModel!.data!.famousProducts![index].price,
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
      data: _homeGetX.homeModel!.data!.latestProducts![index].price,
      fontFamily: FontsApp.fontMedium,
      color: ColorsApp.green,
      fontSize: 16,
    );
  }
 */
