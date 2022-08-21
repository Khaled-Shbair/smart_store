import 'package:flutter/material.dart';

import '../getX/home_getX.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final HomeGetX _homeGetX = Get.put(HomeGetX());
  List<Slider> list = <Slider>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
      //    CarouselSlider(
        //   items: list.map((e) {
        //     //HomeGetX().homeModel.data!.slider.map((e) {
        //     return Image(
        //       image: NetworkImage(e.imageUrl),
        //       width: double.infinity,
        //       fit: BoxFit.cover,
        //     );
        //   }).toList(),
        //   options: CarouselOptions(
        //     height: 250,
        //     initialPage: 0,
        //     enableInfiniteScroll: true,
        //     reverse: false,
        //     autoPlay: true,
        //     autoPlayInterval: const Duration(seconds: 3),
        //     autoPlayAnimationDuration: const Duration(seconds: 1),
        //     autoPlayCurve: Curves.fastOutSlowIn,
        //     scrollDirection: Axis.horizontal,
        //     viewportFraction: 1,
        //   ),
        // ),
        ],
      ),
    );
  }
}
