import '../shared_preferences/pref_controller.dart';
import 'package:http/http.dart' as http;
import '../models/faqs_model.dart';
import '../api/api_paths.dart';
import 'package:get/get.dart';
import 'dart:convert';

class FaqsGetX extends GetxController {
  static FaqsGetX get to => Get.find();
  final _faqs = Rxn<FaqsModel>();
  RxBool loading = false.obs;

  FaqsModel? get faqs => _faqs.value;

  set faqs(FaqsModel? value) => _faqs.value = value;

  @override
  void onInit() {
    super.onInit();
    getFaqsData();
  }

  Future<void> getFaqsData() async {
    loading.value = true;
    var uri = Uri.parse(ApiPath.faqs);
    var response = await http.get(
      uri,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': PrefController().token,
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      faqs = FaqsModel.fromJson(jsonResponse);
      loading.value = false;
    }
  }
}
