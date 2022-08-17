import 'dart:convert';
import 'package:smart_store/api/dio_settings.dart';

import '../api/api_paths.dart';
import '../api/api_response.dart';
import '../../models/user_model.dart';

class AuthApiController {
  Future<ApiResponse> login({
    required String phone,
    required String password,
  }) async {
    var response = await DioSettings.postData(
      url: ApiPath.login,
      data: {
        'mobile': phone,
        'password': password,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.data);
      if (response.statusCode == 200) {
        User student = User.fromJson(jsonResponse);
        // SharedPrefController().save(student: student);
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
    var response = await DioSettings.postData(
      url: ApiPath.register,
      data: {
        'name': name,
        'mobile': phone,
        'password': password,
        'city_id': cityId,
        'gender': gender,
        'STORE_API_KEY': 'a6c2edcb-9738-425a-be8c-a94bff9a68d0',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.data);
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
    var response = await DioSettings.postData(
      url: ApiPath.activate,
      data: {
        'mobile': phone,
        'code': code,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.data);
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
