import 'package:http/http.dart' as http;
import '../models/city_model.dart';
import '../api/api_paths.dart';
import 'package:get/get.dart';
import 'dart:convert';

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

  Future<void> readCities() async {
    loading.value = true;
    var uri = Uri.parse(ApiPath.cities);
    var response = await http.get(uri, headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      cityModel = CityModel.fromJson(jsonResponse);
      loading.value = false;
    }
  }
}
