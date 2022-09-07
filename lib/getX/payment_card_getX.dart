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
    // getCategoryData();
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
      if (response.statusCode == 201) {
        // payment = PaymentModel.fromJson(jsonResponse);//TODO: later
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
