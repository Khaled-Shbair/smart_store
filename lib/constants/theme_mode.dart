import 'fonts.dart';
import 'colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../shared_preferences/pref_controller.dart';

class ThemeModeApp {
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorsApp.scaffoldColorDarkTheme,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: ColorsApp.green,
      ),
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: FontsApp.fontBold,
        color: ColorsApp.green,
        fontSize: 24,
      ),
    ),
  );


  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: ColorsApp.scaffoldColorLightTheme,
    iconTheme: const IconThemeData(color: ColorsApp.green),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: ColorsApp.green,
      ),
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: FontsApp.fontBold,
        color: ColorsApp.green,
        fontSize: 24,
      ),
    ),
  );

  static ThemeMode getThemeMode() {
    return PrefController().mode ? ThemeMode.dark : ThemeMode.light;
  }

  static void changeMode() {
    Get.changeThemeMode(
        PrefController().mode ? ThemeMode.light : ThemeMode.dark);
    PrefController().saveDarkThemeMode(!PrefController().mode);
  }
}
