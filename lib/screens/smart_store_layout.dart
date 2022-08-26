import 'package:flutter/material.dart';

import '../models/screen_model.dart';
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
      backgroundColor: Colors.white12,
      appBar: AppBar(
        titleTextStyle: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        centerTitle: true,
        title: Text(screen[currentIndex].title),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => setState(() => currentIndex = value),
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
      body: screen[currentIndex].widget,
    );
  }
}