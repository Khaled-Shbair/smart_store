import '../shared_preferences/pref_controller.dart';
import 'package:http/http.dart' as http;
import '../api/api_response.dart';
import '../api/api_paths.dart';
import 'package:get/get.dart';
import 'dart:convert';

class ContactRequestsGetX extends GetxController {
  static ContactRequestsGetX get to => Get.find();

  Future<ApiResponse> createContactRequest({
    required String subject,
    required String message,
  }) async {
    var uri = Uri.parse(ApiPath.contactRequests);
    var response = await http.post(uri, headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': PrefController().token,
    }, body: {
      'subject': subject,
      'message': message,
    });
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
}
