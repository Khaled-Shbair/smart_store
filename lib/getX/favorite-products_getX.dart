import 'dart:convert';

import 'package:get/get.dart';

import '../api/api_paths.dart';
import 'package:http/http.dart' as http;
import '../api/api_response.dart';
import '../models/favorite-products_model.dart';
import '../shared_preferences/pref_controller.dart';

class FavoriteProductsGetX extends GetxController {
  static FavoriteProductsGetX get to => Get.find();
  RxBool loading = false.obs;
  final _favoriteProducts = Rxn<FavoriteProductsModel>();

  FavoriteProductsModel? get favoriteProducts => _favoriteProducts.value;

  set favoriteProducts(FavoriteProductsModel? value) {
    _favoriteProducts.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    getFavoriteProductsData();
  }

  Future<void> getFavoriteProductsData() async {
    loading.value = true;
    var uri = Uri.parse(ApiPath.favoriteProducts);
    var response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': PrefController().token,
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      favoriteProducts = FavoriteProductsModel.fromJson(jsonResponse);
      loading.value = false;
    }
  }

  Future<ApiResponse> postFavoriteProductsData({required dynamic id}) async {
    var uri = Uri.parse(ApiPath.favoriteProducts);
    var response = await http.post(
      uri,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': PrefController().token,
      },
      body: {
        'product_id': id,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        favoriteProducts = FavoriteProductsModel.fromJson(jsonResponse);
      }
      return ApiResponse(
        message: jsonResponse['message'],
        status: jsonResponse['status'],
      );
    }
    return ApiResponse(
      message: 'Something went wrong, try again',
      status: false,
    );
  }
}
