import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../widgets/view_details.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  String _selectedLang = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.scaffoldColor,
      appBar: AppBar(
        title: ViewDetails(
          data: 'change_languages'.tr,
          //   AppLocalizations.of(context)!.update_profile,
          fontFamily: FontsApp.fontBold,
          color: ColorsApp.green,
          fontSize: 24,
        ),
        iconTheme: const IconThemeData(color: ColorsApp.green),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("changeLanguages".tr),
          ElevatedButton(
              onPressed: () {
                Get.updateLocale(Locale('ar'));
              },
              child: Text('change')),
        ],
      ),
    );
  }
}
