import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api/api_paths.dart';
import '../models/home_model.dart';
import '../shared_preferences/pref_controller.dart';

class HomeGetX extends GetxController {
  static HomeGetX get to => Get.find();
  RxBool loading = false.obs;
  final _homeModel = Rxn<HomeModel>();

  HomeModel? get homeModel => _homeModel.value;

  set homeModel(HomeModel? value) => _homeModel.value = value;

  @override
  void onInit() {
    super.onInit();
    getHomeData();
  }

  Future<void> getHomeData() async {
    loading.value = true;
    var uri = Uri.parse(ApiPath.home);
    var response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${PrefController().token}',
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      homeModel = HomeModel.fromJson(jsonResponse);
      loading.value = false;
    }
  }

}
