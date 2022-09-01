// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get welcome_back {
    return Intl.message(
      'Welcome back',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Login to start using app`
  String get login_to_start_using_app {
    return Intl.message(
      'Login to start using app',
      name: 'login_to_start_using_app',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forget password?`
  String get forget_password_button {
    return Intl.message(
      'Forget password?',
      name: 'forget_password_button',
      desc: '',
      args: [],
    );
  }

  /// `Create now!`
  String get create_now {
    return Intl.message(
      'Create now!',
      name: 'create_now',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get no_have_an_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'no_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Forget password`
  String get forget_password {
    return Intl.message(
      'Forget password',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter required data!`
  String get enter_required_data {
    return Intl.message(
      'Enter required data!',
      name: 'enter_required_data',
      desc: '',
      args: [],
    );
  }

  /// `Enter your mobile number`
  String get title_forget_password {
    return Intl.message(
      'Enter your mobile number',
      name: 'title_forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number for the verification process, we will send 4 digits code to your phone.`
  String get sub_title_forget_password {
    return Intl.message(
      'Enter your phone number for the verification process, we will send 4 digits code to your phone.',
      name: 'sub_title_forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get new_password {
    return Intl.message(
      'New password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `New password confirmation`
  String get new_password_confirmation {
    return Intl.message(
      'New password confirmation',
      name: 'new_password_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Password confirmation error!`
  String get password_confirmation_error {
    return Intl.message(
      'Password confirmation error!',
      name: 'password_confirmation_error',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get reset_password {
    return Intl.message(
      'Reset password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter reset code!`
  String get enter_reset_code {
    return Intl.message(
      'Enter reset code!',
      name: 'enter_reset_code',
      desc: '',
      args: [],
    );
  }

  /// `Enter 4 Digits Code`
  String get title_reset_password {
    return Intl.message(
      'Enter 4 Digits Code',
      name: 'title_reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter the 4 digits code that you received on your phone.`
  String get sub_title_reset_password {
    return Intl.message(
      'Enter the 4 digits code that you received on your phone.',
      name: 'sub_title_reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Update profile`
  String get update_profile {
    return Intl.message(
      'Update profile',
      name: 'update_profile',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Enter new name`
  String get enter_new_name {
    return Intl.message(
      'Enter new name',
      name: 'enter_new_name',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `new name`
  String get new_name {
    return Intl.message(
      'new name',
      name: 'new_name',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Create address`
  String get create_address {
    return Intl.message(
      'Create address',
      name: 'create_address',
      desc: '',
      args: [],
    );
  }

  /// `Name address`
  String get name_address {
    return Intl.message(
      'Name address',
      name: 'name_address',
      desc: '',
      args: [],
    );
  }

  /// `Info address`
  String get info_address {
    return Intl.message(
      'Info address',
      name: 'info_address',
      desc: '',
      args: [],
    );
  }

  /// `Contact Number`
  String get contact_number {
    return Intl.message(
      'Contact Number',
      name: 'contact_number',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `List addresses`
  String get list_addresses {
    return Intl.message(
      'List addresses',
      name: 'list_addresses',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Update address`
  String get update_address {
    return Intl.message(
      'Update address',
      name: 'update_address',
      desc: '',
      args: [],
    );
  }

  /// `See all >`
  String get see_all {
    return Intl.message(
      'See all >',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `No Data`
  String get no_data {
    return Intl.message(
      'No Data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get category {
    return Intl.message(
      'Categories',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Product category`
  String get product_category {
    return Intl.message(
      'Product category',
      name: 'product_category',
      desc: '',
      args: [],
    );
  }

  /// `Sub category`
  String get sub_category {
    return Intl.message(
      'Sub category',
      name: 'sub_category',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get edit_profile {
    return Intl.message(
      'Edit profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Addresses`
  String get addresses {
    return Intl.message(
      'Addresses',
      name: 'addresses',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_password {
    return Intl.message(
      'Change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get are_you_sure_you_want_to_logout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'are_you_sure_you_want_to_logout',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
