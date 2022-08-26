import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../constants/String.dart';
import '../getX/favorite-products_getX.dart';
import '../getX/home_getX.dart';
import '../getX/rate_products_getX.dart';
import '../widgets/view_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeGetX _homeGetX = Get.put(HomeGetX());
  final RateProductsGetX _rateProducts = Get.put(RateProductsGetX());
  final FavoriteProductsGetX _favoriteProducts =
      Get.put(FavoriteProductsGetX());

  @override
  Widget build(BuildContext context) {
    return GetX<HomeGetX>(
      builder: (controller) {
        if (_homeGetX.loading.isTrue) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: [
            carouselSlider(),
            listCategories(),
            listProduct(),
          ],
        );
      },
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
    return const Center(child: CircularProgressIndicator());
  }

  Widget listCategories() {
    if (_homeGetX.homeModel != null) {
      return Container(
        margin:
            const EdgeInsetsDirectional.only(bottom: 20, start: 10, end: 10),
        height: 100,
        child: ListView.separated(
          itemCount: _homeGetX.homeModel!.data!.categories!.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            return Container(
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    alignment: AlignmentDirectional.center,
                    padding: const EdgeInsetsDirectional.only(bottom: 20),
                    child: Image(
                      image: NetworkImage(
                        _homeGetX.homeModel!.data!.categories![index].imageUrl,
                      ),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: ViewDetails(
                      data:
                          _homeGetX.homeModel!.data!.categories![index].nameEn,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      fontSize: 16,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget listProduct() {
    if (_homeGetX.homeModel != null) {
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
        itemCount: _homeGetX.homeModel!.data!.latestProducts!.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, detailsProduct,
                  arguments: _homeGetX.homeModel!.data!.latestProducts![index]);
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
          _homeGetX.homeModel!.data!.latestProducts![index].imageUrl,
        ),
        fit: BoxFit.fitHeight,
        width: double.infinity,
        height: 180,
      ),
    );
  }

  Widget nameProduct(int index) {
    return ViewDetails(
      data: _homeGetX.homeModel!.data!.latestProducts![index].nameEn,
      fontSize: 20,
      overflow: TextOverflow.ellipsis,
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
          ),
          const SizedBox(width: 10),
          ViewDetails(
            data: _homeGetX.homeModel!.data!.latestProducts![index].price,
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
      data: _homeGetX.homeModel!.data!.latestProducts![index].price,
      fontSize: 16,
    );
  }

  Widget rating(int index) {
    return RatingBarIndicator(
      itemSize: 18,
      rating: double.parse(
          _homeGetX.homeModel!.data!.latestProducts![index].overalRate),
      itemBuilder: (context, index) =>
          const Icon(Icons.star, color: Colors.yellowAccent),
    );
  }
}
