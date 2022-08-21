import 'package:get/get.dart';
import 'package:smart_store/api/api_paths.dart';
import 'package:smart_store/models/home_model.dart';

import '../api/api_response.dart';
/*
class HomeGetX extends GetxController {
  static HomeGetX get to => Get.find();
  RxBool loading = false.obs;
  static late HomeModel homeModel;

  static const String _token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNDZkYTljOTg2ZDc5YThmNzYzYjAwMTU5ZjhhNWQ1NmJjZWQzZjZjM2RjNzVmODYwMWVkMzJmZTUyMjY0YTQyYzUxMDk0Y2Q1ZWZhNzc5YmQiLCJpYXQiOjE2NjA3MzExMDIuNTg5MjM5LCJuYmYiOjE2NjA3MzExMDIuNTg5MjQxLCJleHAiOjE2NjUwNTExMDIuNTg1MDk0LCJzdWIiOiIxMjAyIiwic2NvcGVzIjpbIioiXX0.gH1DqsyHIU5oUsK13zaGrEjT08A3jDnG1GwedbfJ_m6UEFZuodN1hTarPftopRkKZblgo0Rb_iDV0J0mpwWBfUlxSIZx_gX0EMBFmWR5qHyWZFIlcC8RYYTqR4R0gnvN1PBf7SnG6twG_0xPJwV872sf09KzDLGSCBdYV0WdC9sSVthLNMuUpmztuXe6D690PIAWU_fzCugJdl5BAQRRlsrSj9Ia6FTPmhRpbCtIAMN2wvnTNp9aq000ImcFbevlV3EGXTbZ-95s7rTT4QYP_Oq2ekVnmV5wIlhouWBcqxfKySF9rm31KCYNv9rDknVQzAATxqLv6aWOPzXPpjXe_9AkU5eO4R6VW4yXKweqGCnvXPVfyJ-KtderCVNKFttZsQ96H13WpMVw0HS8Ql7tGBR5o3R7vSe6YmapCqBJoiYQUJd1hxNa9o1CBAKAERw1V5gd897kgPmhHvzgH8qSobom66m-FAaYGcRDCiTs1lzk3AaHnmYwtWQuji4kFBoxaBZJgUJ7aR2DvagyxhdOw6NqkCNlPcS3wAaPeLurNdhpzDh4_R1wsQPAjCPM2mgum6-CpQ7iSOHwbmQORrkNmjStirQdze6hk_s5XzmxVr0wEQCeDe9gaeEsQrb6IL38b6AsbovU6oto5hwooudtTUho0ii7y_jbCd5mge23ngc';

  static Future<List<Slider>> getHomeData() async {
    // loading.value = true;
    await DioSettings.getData(
      url: ApiPath.home,
      token: _token,
    ).then(
      (value) {
        if (value.statusCode == 200) {
          homeModel = HomeModel.fromJson(value.data);
          // loading.value = false;
          return homeModel.data!.slider;
        }
      },
    );
    return [];
  }
}
*/