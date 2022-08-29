import 'dart:convert';
import 'api_paths.dart';
import 'api_response.dart';
import '../../models/user_model.dart';
import 'package:http/http.dart' as http;
import '../shared_preferences/pref_controller.dart';

class AuthApiController {
  final String lang = 'en';

  Future<ApiResponse> login({
    required String phone,
    required String password,
  }) async {
    var uri = Uri.parse(ApiPath.login);
    var response = await http.post(
      uri,
      body: {'mobile': phone, 'password': password},
      headers: {
        'lang': lang,
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

  Future<ApiResponse> resetPassword({
    required String phone,
    required String code,
    required String password,
  }) async {
    var uri = Uri.parse(ApiPath.resetPassword);
    var response = await http.post(uri, headers: {
      'lang': lang,
      'Content-Type': 'application/x-www-form-urlencoded',
    }, body: {
      'mobile': phone,
      'code': code,
      'password': password,
      'password_confirmation': password,
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

  Future<ApiResponse> changePassword({
    required String password,
    required String newPassword,
  }) async {
    var uri = Uri.parse(ApiPath.changePassword);
    var response = await http.post(uri, headers: {
      'lang': lang,
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': PrefController().token,
    }, body: {
      'current_password': password,
      'new_password': newPassword,
      'new_password_confirmation': newPassword,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
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

  Future<ApiResponse> forgetPassword({required String phone}) async {
    var uri = Uri.parse(ApiPath.forgetPassword);
    var response = await http.post(uri, headers: {
      'lang': lang,
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      'mobile': phone,
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(jsonResponse['code']);
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

  Future<ApiResponse> logout() async {
    var uri = Uri.parse(ApiPath.logout);
    var response = await http.get(
      uri,
      headers: {
        'lang': lang,
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': PrefController().token,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        PrefController().clear();
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

///////////////////////////////////////////////////////////////////////////////
  Future<ApiResponse> updateProfile({
    required dynamic cityOd,
    required String name,
    required String gender,
  }) async {
    var uri = Uri.parse(ApiPath.updateProfile);
    var response = await http.post(
      uri,
      headers: {
        'lang': lang,
        'Authorization': PrefController().token,
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'city_id': cityOd,
        'name': name,
        'gender': gender,
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

///////////////////////////////////////////////////////////////////////////////
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

  Future<ApiResponse> activateAccount({
    required String phone,
    required String code,
  }) async {
    var uri = Uri.parse(ApiPath.activate);
    var response = await http.post(
      uri,
      headers: {
        'lang': lang,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'code': code,
        'mobile': phone,
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
}
