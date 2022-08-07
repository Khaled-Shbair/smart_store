import 'package:flutter/material.dart';
import 'package:smart_store/screens/auth%20screen/forget%20password.dart';
import 'package:smart_store/screens/auth%20screen/login%20screen.dart';
import 'package:smart_store/screens/auth%20screen/register%20screen.dart';
import 'package:smart_store/screens/main%20Screen.dart';

import 'constants/String.dart';

class AppRouters {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case mainScreen:
        return MaterialPageRoute(builder: (context) => const MainScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case forgetPassword:
        return MaterialPageRoute(builder: (context) => const ForgetPassword());
      // case activateAccountScreen':
      // return MaterialPageRoute(builder: (context) => const ActivateAccountScreen());

    }
    return null;
  }
}
