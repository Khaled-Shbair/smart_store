import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getX/bottom_navigation_bar_getX.dart';

class SmartStoreLayout extends StatelessWidget {
  SmartStoreLayout({Key? key}) : super(key: key);
  final BottomNavigationBarGetX _barGetX = Get.put(BottomNavigationBarGetX());

  @override
  Widget build(BuildContext context) {
    return GetX<BottomNavigationBarGetX>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white12,
        appBar: AppBar(
          titleTextStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          centerTitle: true,
          title: Text(_barGetX.listTitle[_barGetX.currentIndex.value]),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _barGetX.currentIndex.value,
          onTap: (value) => _barGetX.changeIndex(value),
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          iconSize: 28,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          ],
        ),
        body: _barGetX.listScreen[_barGetX.currentIndex.value],
      );
    });
  }
}
