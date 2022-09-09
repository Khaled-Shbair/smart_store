import '../shared_preferences/pref_controller.dart';
import 'package:http/http.dart' as http;
import '../models/orders_model.dart';
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

  Future<void> createOrder() async {}

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
