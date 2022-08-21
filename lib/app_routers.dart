import 'package:flutter/material.dart';
import 'constants/String.dart';
import 'screens/auth_screen/forget_password.dart';
import 'screens/auth_screen/login_screen.dart';
import 'screens/auth_screen/register_screen.dart';
import 'screens/auth_screen/send_code_screen.dart';
import 'screens/home_screen.dart';
import 'screens/launch_screen.dart';

class AppRouters {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case forgetPassword:
        return MaterialPageRoute(builder: (context) => const ForgetPassword());
      case sendCodeScreen:
        final phone = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => SendCodeScreen(phone: phone));
      default:
        return MaterialPageRoute(builder: (context) => const LaunchScreen());
    }
  }
}
