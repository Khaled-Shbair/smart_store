import 'package:flutter/material.dart';
import 'package:smart_store/app%20routers.dart';

import 'api/dio_settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioSettings.init();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouters.onGenerateRoute,
    );
  }
}
