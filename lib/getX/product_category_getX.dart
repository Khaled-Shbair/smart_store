import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api/api_paths.dart';
import '../models/product_category_model.dart';
import '../shared_preferences/pref_controller.dart';

class ProductCategoryGetX extends GetxController {
  static ProductCategoryGetX get to => Get.find();
  RxBool loading = false.obs;
  RxInt id = 191.obs;

  @override
  void onInit() {
    super.onInit();
    getProductCategoryData();
  }

  final _productCategory = Rxn<ProductCategoryModel>();

  ProductCategoryModel? get productCategory => _productCategory.value;

  set productCategory(ProductCategoryModel? value) {
    _productCategory.value = value;
  }

  Future<void> getProductCategoryData() async {
    loading.value = true;
    var uri = Uri.parse('${ApiPath.subCategories}$id');
    var response = await http.get(uri, headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': PrefController().token,
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      productCategory = ProductCategoryModel.fromJson(jsonResponse);
      loading.value = false;
    }
  }
}
