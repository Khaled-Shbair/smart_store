import 'dart:convert';
import 'package:get/get.dart';

import '../api/api_paths.dart';
import '../models/city_model.dart';
/*
class CitiesGetX extends GetxController {
  static CitiesGetX get to => Get.find();
  CityModel? cityModel;

  Future<List<City>> readCities() async {
    dynamic response;
    response = await DioSettings.getData(
      url: ApiPath.cities,
      query: {},
    ).then(
      (value) {
        print(response.data);
        print(cityModel!.list);
        return CityModel.fromJson(value.data);
      },
    );

    return [];
  }

  late CityModel cityModels;

  Future<List<City>> readUsers() async {
    var response = await DioSettings.getData(url: ApiPath.cities);
    if (response.statusCode == 200) {
      cityModels = CityModel.fromJson(response.data);
      return cityModels.list;
    }
    return [];
  }
}
*/