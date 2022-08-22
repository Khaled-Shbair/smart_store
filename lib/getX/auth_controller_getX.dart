import 'dart:convert';
import 'package:get/get.dart';
import 'package:smart_store/shared_preferences/pref_controller.dart';
import '../api/api_paths.dart';
import '../api/api_response.dart';
import '../../models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthApiController extends GetxController {
  static AuthApiController get to => Get.find();
  UserModel? userModel;

  Future<ApiResponse> login({
    required String phone,
    required String password,
  }) async {
    var uri = Uri.parse(ApiPath.login);
    var response = await http.post(
      uri,
      body: {'mobile': phone, 'password': password},
      headers: {
        'lang': 'en',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(jsonResponse);
        PrefController().save(userModel.data!);
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

  Future<ApiResponse> register({
    required String name,
    required String phone,
    required String password,
    required String cityId,
    required String gender,
  }) async {
    var uri = Uri.parse(ApiPath.register);

    var response = await http.post(
      uri,
      body: {
        'name': name,
        'mobile': phone,
        'password': password,
        'city_id': cityId,
        'gender': gender,
        'STORE_API_KEY': 'a6c2edcb-9738-425a-be8c-a94bff9a68d0',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        // UserModel userModel = UserModel.fromJson(jsonResponse);
        print('201 ,created');
      }
      print('400 ,un created');
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

  Future<ApiResponse> sendCode(
      {required String phone, required String code}) async {
    var uri = Uri.parse(ApiPath.activate);
    var response = await http.post(uri, body: {
      'mobile': phone,
      'code': code,
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {}
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
