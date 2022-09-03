import '../shared_preferences/pref_controller.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'category_screen.dart';
import 'favorite_screen.dart';
import 'settings_screen.dart';
import 'home_screen.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  final List<Widget> screen = <Widget>[
    const HomeScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    const SettingsScreen()
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => setState(() => currentIndex = value),
        selectedItemColor: ColorsApp.green,
        unselectedItemColor: PrefController().mode
            ? ColorsApp.colorDarkTheme
            : ColorsApp.geryBold,
        showSelectedLabels: false,
        iconSize: 28,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
      body: screen[currentIndex],
    );
  }
}
