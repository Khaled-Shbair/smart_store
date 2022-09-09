import '../shared_preferences/pref_controller.dart';
import 'package:http/http.dart' as http;
import '../models/payment_model.dart';
import '../api/api_response.dart';
import '../api/api_paths.dart';
import 'package:get/get.dart';
import 'dart:convert';

class PaymentCardGetX extends GetxController {
  static PaymentCardGetX get to => Get.find();
  RxBool loading = false.obs;

  final _payment = Rxn<PaymentModel>();

  PaymentModel? get payment => _payment.value;

  set payment(PaymentModel? value) => _payment.value = value;

  @override
  void onInit() {
    super.onInit();
    getPaymentData();
  }

  Future<ApiResponse> create({
    required String holderName,
    required String cardNumber,
    required String expDate,
    required String cvv,
    required String type,
  }) async {
    var uri = Uri.parse(ApiPath.paymentCards);
    var response = await http.post(
      uri,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': PrefController().token,
      },
      body: {
        'holder_name': holderName,
        'card_number': cardNumber,
        'exp_date': expDate,
        'cvv': cvv,
        'type': type,
      },
    );
    if (response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 401) {
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

  Future<ApiResponse> getPaymentData() async {
    loading.value = true;
    var uri = Uri.parse(ApiPath.paymentCards);
    var response = await http.get(
      uri,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': PrefController().token,
      },
    );
    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        payment = PaymentModel.fromJson(jsonResponse);
        loading.value = false;
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
