import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../getX/home_getX.dart';
import '../api/api_paths.dart';
import '../api/api_response.dart';
import '../shared_preferences/pref_controller.dart';

class RateProductsGetX extends GetxController {
  static RateProductsGetX get to => Get.find();

  Future<ApiResponse> postRateProducts({
    required dynamic id,
    required dynamic rate,
  }) async {
    var uri = Uri.parse(ApiPath.rateProducts);
    var response = await http.post(
      uri,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Content-Type': 'application/x-www-form-urlencoded',
        'lang': PrefController().language,
        'Authorization': PrefController().token,
      },
      body: {
        'product_id': id,
        'rate': rate,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        HomeGetX.to.getHomeData();
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
