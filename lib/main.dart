import 'shared_preferences/pref_controller.dart';
import 'package:flutter/material.dart';
import 'constants/theme_mode.dart';
import 'language/translation.dart';
import 'getX/address_getX.dart';
import 'getX/cities_getX.dart';
import 'package:get/get.dart';
import 'app_routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefController().init();
  runApp(MyApp(appRouters: AppRouters()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.appRouters}) : super(key: key);

  final AppRouters appRouters;
  final CitiesGetX citiesGetX = Get.put(CitiesGetX());
  final AddressGetX addressGetX = Get.put(AddressGetX());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Translation(),
      locale: Locale(PrefController().language),
      fallbackLocale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouters.onGenerateRoute,
      theme: ThemeModeApp.lightTheme,
      darkTheme: ThemeModeApp.darkTheme,
      themeMode: ThemeModeApp.getThemeMode(),
    );
  }
}
