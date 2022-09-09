import 'screens/payment_ways_screen/create_payment_card_screen.dart';
import 'screens/payment_ways_screen/update_payment_card_screen.dart';
import 'screens/payment_ways_screen/list_payment_cards_screen.dart';
import 'screens/address_screen/create_address_screen.dart';
import 'screens/address_screen/list_addresses_screen.dart';
import 'screens/address_screen/update_address_screen.dart';
import 'screens/auth_screen/activate_account_screen.dart';
import 'screens/auth_screen/change_password_screen.dart';
import 'screens/auth_screen/reset_password_screen.dart';
import 'screens/auth_screen/update_profile_screen.dart';
import 'package:smart_store/models/address_model.dart';
import 'screens/auth_screen/forget_password.dart';
import 'screens/auth_screen/register_screen.dart';
import 'screens/auth_screen/login_screen.dart';
import 'screens/change_languages_screen.dart';
import 'screens/product_category_screen.dart';
import 'screens/contact_requests_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/sub_category_screen.dart';
import 'package:flutter/material.dart';
import 'screens/category_screen.dart';
import 'screens/launch_screen.dart';
import 'models/payment_model.dart';
import 'screens/home_screen.dart';
import 'screens/faqs_screen.dart';
import 'screens/app_layout.dart';
import 'constants/routes.dart';
import 'models/product.dart';

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
      case faqsScreen:
        return MaterialPageRoute(builder: (context) => const FaqsScreen());
      case notificationsScreen:
        return MaterialPageRoute(builder: (context) => NotificationsScreen());
      case contactRequestsScreen:
        return MaterialPageRoute(
            builder: (context) => const ContactRequestsScreen());
      case listPaymentCardsScreen:
        return MaterialPageRoute(
            builder: (context) => const ListPaymentCardsScreen());
      case createPaymentCardScreen:
        return MaterialPageRoute(
            builder: (context) => const CreatePaymentCardScreen());
      case changeLanguageScreen:
        return MaterialPageRoute(
            builder: (context) => const ChangeLanguageScreen());
      case listAddressesScreen:
        return MaterialPageRoute(
            builder: (context) => const ListAddressesScreen());
      case createAddressScreen:
        return MaterialPageRoute(
            builder: (context) => const CreateAddressScreen());
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
      case updatePaymentCardScreen:
        final payment = settings.arguments as Payment;
        return MaterialPageRoute(
            builder: (context) => UpdatePaymentCardScreen(payment: payment));
      case activateAccountScreen:
        final phone = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => ActivateAccountScreen(phone: phone));
      case productDetailsScreen:
        final product = settings.arguments as Products;
        return MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product));
      case resetPasswordScreen:
        final phone = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(phone: phone));
      case updateAddressScreen:
        final addressModel = settings.arguments as Address;
        return MaterialPageRoute(
            builder: (context) => UpdateAddressScreen(address: addressModel));
      default:
        return MaterialPageRoute(builder: (context) => const LaunchScreen());
    }
  }
}
