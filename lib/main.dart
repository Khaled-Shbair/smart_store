import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app_routers.dart';
import 'constants/colors.dart';
import 'constants/fonts.dart';
import 'language/translation.dart';
import 'shared_preferences/pref_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefController().init();
  runApp(MyApp(appRouters: AppRouters()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouters}) : super(key: key);

  final AppRouters appRouters;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Translation(),
      locale: Locale(PrefController().language),
      fallbackLocale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouters.onGenerateRoute,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorsApp.scaffoldColorLightTheme,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
      ),

      darkTheme: ThemeData(
        scaffoldBackgroundColor: ColorsApp.scaffoldColorDarkTheme,
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
      ),
      themeMode: ThemeMode.dark,
    );
  }
}
