import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api/api_paths.dart';
import '../models/category_model.dart';
import '../shared_preferences/pref_controller.dart';

class CategoryGetX extends GetxController {
  static CategoryGetX get to => Get.find();
  final _category = Rxn<CategoryModel>();
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCategoryData();
  }

  CategoryModel? get category => _category.value;

  set category(CategoryModel? value) => _category.value = value;

  Future<void> getCategoryData() async {
    loading.value = true;
    var uri = Uri.parse(ApiPath.categories);
    var response = await http.get(uri, headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': PrefController().token,
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      category = CategoryModel.fromJson(jsonResponse);
      loading.value = false;
    }
  }
}
