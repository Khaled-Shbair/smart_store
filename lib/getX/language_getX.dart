import 'package:get/get.dart';

import '../shared_preferences/pref_controller.dart';

class LanguageGetX extends GetxController {
  static LanguageGetX get to => Get.find();
  RxString language = PrefController().language.obs;

 // @override
 // void onInit() {
 //   super.onInit();
 //   changeLanguage();
 // }

  void changeLanguage() {
    language.value = language.value == 'en' ? 'ar' : 'en';
    PrefController().changeLanguage(language: language.value);
    update();
  }
}
