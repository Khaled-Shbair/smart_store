import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/category_screen.dart';
import '../screens/favorite_screen.dart';
import '../screens/home_screen.dart';
import '../screens/notification_screen.dart';

class BottomNavigationBarGetX extends GetxController {
  static BottomNavigationBarGetX get to => Get.find();
  RxInt currentIndex = 0.obs;
  final RxList<Widget> listScreen = <Widget>[
    const HomeScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    const NotificationScreen(),
  ].obs;
  final RxList<String> listTitle = <String>[
    'Home',
    'Category',
    'Favorite',
    'Notification',
  ].obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
