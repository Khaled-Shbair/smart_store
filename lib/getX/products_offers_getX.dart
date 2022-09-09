import '../shared_preferences/pref_controller.dart';
import '../models/products_offers_model.dart';
import 'package:http/http.dart' as http;
import '../api/api_paths.dart';
import 'package:get/get.dart';
import 'dart:convert';

class ProductsOffersGetX extends GetxController {
  static ProductsOffersGetX get to => Get.find();
  final _productsOffers = Rxn<ProductsOffersModel>();
  RxBool loading = false.obs;

  ProductsOffersModel? get productsOffers => _productsOffers.value;

  set productsOffers(ProductsOffersModel? value) =>
      _productsOffers.value = value;

  Future<void> getProductsOffers() async {
    loading.value = true;
    var uri = Uri.parse(ApiPath.offers);
    var response = await http.get(
      uri,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': PrefController().token,
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      productsOffers = ProductsOffersModel.fromJson(jsonResponse);
      loading.value = false;
    }
  }
}
