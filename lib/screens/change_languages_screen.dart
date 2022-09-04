import '../shared_preferences/pref_controller.dart';
import 'package:flutter/material.dart';
import '../widgets/button_auth.dart';
import 'package:get/get.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('change_languages'.tr)),
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
          SizedBox(height: MediaQuery.of(context).size.height / 50),
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
