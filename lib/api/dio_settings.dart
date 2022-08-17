import 'package:dio/dio.dart';

import 'api_paths.dart';

class DioSettings {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiPath.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
    };
    return await dio.post(url, data: data);
  }
}
