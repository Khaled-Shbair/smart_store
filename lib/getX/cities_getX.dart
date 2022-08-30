import 'dart:convert';
import 'package:get/get.dart';

import '../api/api_paths.dart';
import '../models/city.dart';
import '../models/city_model.dart';
import 'package:http/http.dart' as http;

class CitiesGetX extends GetxController {
  static CitiesGetX get to => Get.find();
  RxBool loading = false.obs;

  final _cityModel = Rxn<CityModel>();

  CityModel? get cityModel => _cityModel.value;

  set cityModel(CityModel? value) {
    _cityModel.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    readCities();
  }

  Future<List<City>> readCities() async {
    loading.value = true;
    var uri = Uri.parse(ApiPath.cities);
    var response = await http.get(uri, headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      cityModel = CityModel.fromJson(jsonResponse);
      loading.value = false;
      return cityModel!.list;
    }
    return [];
  }
}
