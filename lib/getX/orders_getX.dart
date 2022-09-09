import '../shared_preferences/pref_controller.dart';
import 'package:http/http.dart' as http;
import '../models/orders_model.dart';
import '../api/api_response.dart';
import '../api/api_paths.dart';
import 'package:get/get.dart';
import 'dart:convert';

class OrdersGetX extends GetxController {
  static OrdersGetX get to => Get.find();
  RxBool loading = false.obs;

  final _order = Rxn<OrdersModel>();

  OrdersModel? get order => _order.value;

  set order(OrdersModel? value) => _order.value = value;

  @override
  void onInit() {
    super.onInit();
    getAllOrdersData();
  }

  Future<void> getAllOrdersData() async {
    loading.value = true;
    var uri = Uri.parse(ApiPath.orders);
    var response = await http.get(
      uri,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': PrefController().token,
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      order = OrdersModel.fromJson(jsonResponse);
      loading.value = false;
    }
  }

  Future<ApiResponse> createOrder({
    required dynamic productId,
    required dynamic quantity,
    required dynamic paymentType,
    required dynamic addressId,
    required dynamic cardId,
  }) async {
    var uri = Uri.parse(ApiPath.orders);
    var response = await http.post(
      uri,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
        'lang': 'en',
        'Authorization': PrefController().token,
      },
      body: {
        'cart': '[{"product_id":$productId,"quantity":$quantity}]',
        'payment_type': paymentType,
        'address_id': addressId,
        'card_id': cardId
      },
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
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

  Future<void> getOrderDetails({required int id}) async {
    loading.value = true;
    var uri = Uri.parse('${ApiPath.orders}/$id');
    var response = await http.get(
      uri,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': PrefController().token,
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      //order = OrdersModel.fromJson(jsonResponse);
      loading.value = false;
    }
  }
}
