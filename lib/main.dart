import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_routers.dart';
import 'language/translation.dart';
import 'shared_preferences/pref_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefController().init();
  runApp(MyApp(appRouters: AppRouters()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.appRouters,
  }) : super(key: key);

  final AppRouters appRouters;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Translation(),
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouters.onGenerateRoute,
    );
  }
}
