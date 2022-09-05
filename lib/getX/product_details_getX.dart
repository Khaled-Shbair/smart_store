import '../shared_preferences/pref_controller.dart';
import '../models/product_details_model.dart';
import 'package:http/http.dart' as http;
import '../api/api_paths.dart';
import 'package:get/get.dart';
import 'dart:convert';

class ProductDetailsGetX extends GetxController {
  static ProductDetailsGetX get to => Get.find();
  RxBool loading = false.obs;
  RxInt id = 46.obs;
  final _productDetails = Rxn<ProductDetailsModel>();

  ProductDetailsModel? get productDetails => _productDetails.value;

  set productDetails(ProductDetailsModel? value) =>
      _productDetails.value = value;

  @override
  void onInit() {
    super.onInit();
    getProductDetailsData();
  }

  Future<void> getProductDetailsData() async {
    loading.value = true;
    var uri = Uri.parse('${ApiPath.products}$id');
    var response = await http.get(
      uri,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': PrefController().token,
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      productDetails = ProductDetailsModel.fromJson(jsonResponse);
      loading.value = false;
    }
  }
}
