import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/screen_model.dart';
import '../widgets/appBar_app.dart';
import 'category_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'notification_screen.dart';

class SmartStoreLayout extends StatefulWidget {
  const SmartStoreLayout({Key? key}) : super(key: key);

  @override
  State<SmartStoreLayout> createState() => _SmartStoreLayoutState();
}

class _SmartStoreLayoutState extends State<SmartStoreLayout> {
  final List<Screen> screen = <Screen>[
    Screen(title: 'Home', widget: const HomeScreen()),
    Screen(title: 'Category', widget: const CategoryScreen()),
    Screen(title: 'Favorite', widget: const FavoriteScreen()),
    Screen(title: 'Notification', widget: const NotificationScreen()),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarApp(title: screen[currentIndex].title),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => setState(() => currentIndex = value),
        selectedItemColor: MyColors.green,
        unselectedItemColor: MyColors.geryBold,
        showSelectedLabels: false,
        iconSize: 28,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
        ],
      ),
      body: screen[currentIndex].widget,
    );
  }
}
