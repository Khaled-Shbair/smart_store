import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api/api_paths.dart';
import '../models/sub_category_model.dart';
import '../shared_preferences/pref_controller.dart';

class SubCategoryModelGetX extends GetxController {
  static SubCategoryModelGetX get to => Get.find();
  RxBool loading = false.obs;
  final _subCategory = Rxn<SubCategoryModel>();

  SubCategoryModel? get subCategory => _subCategory.value;

  set subCategory(SubCategoryModel? value) => _subCategory.value = value;
  RxInt id = 118.obs;

  @override
  void onInit() {
    super.onInit();
    getSubCategoryData();
  }

  Future<void> getSubCategoryData() async {
    loading.value = true;
    var uri = Uri.parse('${ApiPath.categories}/$id');
    var response = await http.get(uri, headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': PrefController().token,
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      subCategory = SubCategoryModel.fromJson(jsonResponse);
      loading.value = false;
    }
  }
}
