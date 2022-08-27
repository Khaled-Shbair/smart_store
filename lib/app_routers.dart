import 'package:flutter/material.dart';
import 'constants/routes.dart';
import 'models/home_model.dart';
import 'screens/auth_screen/forget_password.dart';
import 'screens/auth_screen/login_screen.dart';
import 'screens/auth_screen/register_screen.dart';
import 'screens/auth_screen/reset_password_screen.dart';
import 'screens/category_screen.dart';
import 'screens/details product.dart';
import 'screens/home_screen.dart';
import 'screens/launch_screen.dart';
import 'screens/product_category_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/smart_store_layout.dart';
import 'screens/sub_category_screen.dart';

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
      case smartStoreLayout:
        return MaterialPageRoute(
            builder: (context) => const SmartStoreLayout());
      case subCategoryScreen:
        return MaterialPageRoute(
            builder: (context) => const SubCategoryScreen());
      case productCategoryScreen:
        return MaterialPageRoute(
            builder: (context) => const ProductCategoryScreen());
      case productDetailsScreen:
        return MaterialPageRoute(
            builder: (context) => const ProductDetailsScreen());
      case resetPasswordScreen:
        final phone = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(phone: phone));
      case detailsProduct:
        final latestProducts = settings.arguments as Products;
        return MaterialPageRoute(
            builder: (context) => DetailsProduct(product: latestProducts));
      default:
        return MaterialPageRoute(builder: (context) => const LaunchScreen());
    }
  }
}
