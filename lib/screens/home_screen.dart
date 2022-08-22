import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_store/getX/home_getX.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeGetX _homeGetX = Get.put(HomeGetX());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<HomeGetX>(
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
      ),
    );
  }

  Widget carouselSlider() {
    if (_homeGetX.homeModel != null) {
      return CarouselSlider(
        items: _homeGetX.homeModel!.data!.slider!.map((e) {
          return Image(
            fit: BoxFit.cover,
            width: double.infinity,
            image: NetworkImage(e.imageUrl),
          );
        }).toList(),
        options: CarouselOptions(
          height: 250,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
          viewportFraction: 1,
        ),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget listCategories() {
    if (_homeGetX.homeModel != null) {
      return Container(
        margin: const EdgeInsetsDirectional.only(
          top: 20,
          bottom: 20,
          start: 10,
          end: 10,
        ),
        height: 100,
        child: ListView.separated(
          itemCount: _homeGetX.homeModel!.data!.categories!.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(
                      _homeGetX.homeModel!.data!.categories![index].imageUrl,
                    ),
                    height: 100,
                    width: 100,
                  ),
                  Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.8),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      _homeGetX.homeModel!.data!.categories![index].nameEn,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
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
          childAspectRatio: 1 / 1.7,
        ),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: NetworkImage(
                    _homeGetX.homeModel!.data!.latestProducts![index].imageUrl,
                  ),
                  width: double.infinity,
                  height: 200,
                ),
              ],
            ),
          );
        },
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}
