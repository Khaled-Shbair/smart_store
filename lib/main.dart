import 'package:flutter/material.dart';
import 'package:smart_store/screens/auth_screen/login_screen.dart';
import 'app_routers.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouters.onGenerateRoute,
    );
  }
}
