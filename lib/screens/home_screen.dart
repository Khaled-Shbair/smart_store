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

           _homeGetX.getHomeDatas();
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: [

              carouselSlider(),
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
}
