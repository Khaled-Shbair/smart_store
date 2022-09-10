import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../shared_preferences/pref_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../getX/favorite-products_getX.dart';
import '../../getX/rate_products_getX.dart';
import '../../widgets/view_details.dart';
import 'package:flutter/material.dart';
import '../../widgets/title_list.dart';
import '../../api/api_response.dart';
import '../../constants/colors.dart';
import '../../constants/routes.dart';
import '../../constants/fonts.dart';
import '../../widgets/loading.dart';
import '../../getX/home_getX.dart';
import '../../utils/helpers.dart';
import 'package:get/get.dart';

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
      appBar: AppBar(title: Text('home'.tr)),
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
            height: MediaQuery.of(context).size.height / 3.5,
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
              title: 'category'.tr,
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
                itemCount: _homeGetX.homeModel!.data!.categories!.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 10);
                },
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 6,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      color: ColorsApp.background.withAlpha(117),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.aspectRatio * 50,
                          backgroundColor: Colors.white,
                          child: Image(
                            image: NetworkImage(
                              _homeGetX
                                  .homeModel!.data!.categories![index].imageUrl,
                            ),
                            height: MediaQuery.of(context).size.height * 50,
                            width: MediaQuery.of(context).size.width * 50,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 70),
                        ViewDetails(
                          data: PrefController().language == 'en'
                              ? _homeGetX
                                  .homeModel!.data!.categories![index].nameEn
                              : _homeGetX
                                  .homeModel!.data!.categories![index].nameAr,
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
              title: 'products'.tr,
              onPressed: () {
                //TODO: later
                //  Navigator.pushNamed(context, );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 100),
            GridView.builder(
              shrinkWrap: true,
              primary: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: (MediaQuery.of(context).size.width * 190) /
                    (MediaQuery.of(context).size.height * 130),
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
                      sizeBoxHeight(130),
                      ViewDetails(
                        data: PrefController().language == 'en'
                            ? _homeGetX
                                .homeModel!.data!.latestProducts![index].nameEn
                            : _homeGetX
                                .homeModel!.data!.latestProducts![index].nameAr,
                        fontSize: 18,
                        color: ColorsApp.black,
                        fontFamily: FontsApp.fontMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      priceProduct(index),
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
              height: MediaQuery.of(context).size.height / 4.4,
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.all(2),
            color: ColorsApp.red,
            child: ViewDetails(
              data: 'discount'.tr,
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
            height: MediaQuery.of(context).size.height / 4.4,
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
          sizeBoxWidth(40),
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

  Widget sizeBoxHeight(double height) =>
      SizedBox(height: MediaQuery.of(context).size.height / height);

  Widget sizeBoxWidth(double width) =>
      SizedBox(width: MediaQuery.of(context).size.width / width);

  void addFavorite(int index) async {
    ApiResponse apiResponse = await favoriteProducts.postFavoriteProductsData(
        id: _homeGetX.homeModel!.data!.latestProducts![index].id.toString());
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
  }
}
