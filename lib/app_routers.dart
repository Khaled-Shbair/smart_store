import 'package:flutter/material.dart';
import 'package:smart_store/models/address_model.dart';
import 'constants/routes.dart';
import 'models/product.dart';
import 'screens/address/create_address_screen.dart';
import 'screens/address/list_addresses_screen.dart';
import 'screens/address/update_address_screen.dart';
import 'screens/auth_screen/change_password_screen.dart';
import 'screens/auth_screen/forget_password.dart';
import 'screens/auth_screen/login_screen.dart';
import 'screens/auth_screen/register_screen.dart';
import 'screens/auth_screen/reset_password_screen.dart';
import 'screens/auth_screen/update_profile_screen.dart';
import 'screens/category_screen.dart';
import 'screens/details product.dart';
import 'screens/home_screen.dart';
import 'screens/launch_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/product_category_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/app_layout.dart';
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
      case categoryScreen:
        return MaterialPageRoute(builder: (context) => const CategoryScreen());
      case appLayout:
        return MaterialPageRoute(builder: (context) => const AppLayout());
      case listAddressesScreen:
        return MaterialPageRoute(
            builder: (context) => const ListAddressesScreen());
      case createAddressScreen:
        return MaterialPageRoute(
            builder: (context) => const CreateAddressScreen());
      case notificationsScreen:
        return MaterialPageRoute(
            builder: (context) => const NotificationsScreen());
      case updateProfileScreen:
        return MaterialPageRoute(
            builder: (context) => const UpdateProfileScreen());
      case changePasswordScreen:
        return MaterialPageRoute(
            builder: (context) => const ChangePasswordScreen());
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
      case updateAddressScreen:
        final addressModel = settings.arguments as Address;
        return MaterialPageRoute(
            builder: (context) => UpdateAddressScreen(address: addressModel));
      case detailsProduct:
        final latestProducts = settings.arguments as Products;
        return MaterialPageRoute(
            builder: (context) => DetailsProduct(product: latestProducts));
      default:
        return MaterialPageRoute(builder: (context) => const LaunchScreen());
    }
  }
}
