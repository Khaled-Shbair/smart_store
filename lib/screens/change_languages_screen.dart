import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared_preferences/pref_controller.dart';
import '../widgets/button_auth.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../widgets/view_details.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('change_languages'.tr),
        iconTheme: const IconThemeData(color: ColorsApp.green),
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
          top: 50,
        ),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ButtonAuth(
            text: 'اللغة العربية',
            onPressed: () {
              Get.updateLocale(const Locale('ar'));
              PrefController().changeLanguage(language: 'ar');
            },
          ),
          const SizedBox(height: 20),
          ButtonAuth(
            text: 'English',
            onPressed: () {
              Get.updateLocale(const Locale('en'));
              PrefController().changeLanguage(language: 'en');
            },
          ),
        ],
      ),
    );
  }
}
