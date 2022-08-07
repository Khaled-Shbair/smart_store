import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_store/api/api%20paths.dart';

import '../../models/api response.dart';
import '../../models/user.dart';

class AuthApiController {
  Future<ApiResponse> login(
      {required String phone, required String password}) async {
    var httpUri = Uri.parse(ApiPath.login);
    var response = await http.post(httpUri, body: {
      'mobile': phone,
      'password': password,
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var jsonObject = jsonResponse[''];
        User student = User.fromJson(jsonObject);
        // SharedPrefController().save(student: student);
      }
      return ApiResponse(
        message: jsonResponse['message'],
        status: jsonResponse['status'],
      );
    }
    return ApiResponse(
        message: 'Something went wrong, try again', status: false);
  }

  Future<ApiResponse> register(
      {required String name,
      required String phone,
      required String password,
      required String cityId,
      required String gender}) async {
    var httpUri = Uri.parse(ApiPath.register);
    var response = await http.post(httpUri, body: {
      'name': name,
      'mobile': phone,
      'password': password,
      'city_id': cityId,
      'gender': gender,
    });
    if (response.statusCode == 201 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
        message: jsonResponse['message'],
        status: jsonResponse['status'],
      );
    }
    return ApiResponse(
        message: 'Something went wrong, try again', status: false);
  }

  Future<ApiResponse> sendCode(
      {required String phone, required String code}) async {
    var httpUri = Uri.parse(ApiPath.activate);
    var response = await http.post(httpUri, body: {
      'mobile': phone,
      'code': code,
    });
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
}
