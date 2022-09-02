import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared_preferences/pref_controller.dart';
import 'colors.dart';
import 'fonts.dart';

class ThemeModes {
  final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorsApp.scaffoldColorDarkTheme,
    iconTheme: const IconThemeData(color: ColorsApp.green),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: FontsApp.fontBold,
        color: ColorsApp.green,
        fontSize: 24,
      ),
    ),
  );

  final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: ColorsApp.scaffoldColorLightTheme,
    iconTheme: const IconThemeData(color: ColorsApp.green),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: FontsApp.fontBold,
        color: ColorsApp.green,
        fontSize: 24,
      ),
    ),
  );

  ThemeMode getThemeMode() {
    return PrefController().mode ? ThemeMode.dark : ThemeMode.light;
  }

  void changeMode() {
    Get.changeThemeMode(
        PrefController().mode ? ThemeMode.light : ThemeMode.dark);
    PrefController().saveDarkThemeMode(!PrefController().mode);
  }
}
