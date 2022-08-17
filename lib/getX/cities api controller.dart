import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/api_paths.dart';
import '../models/city_model.dart';

class CitiesApiController {
  Future<List<City>> readCities() async {
    var httpUri = Uri.parse(ApiPath.cities);
    var response = await http.get(httpUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
      //var dataJsonArray = jsonResponse['list'] as List;
      //List<City> cities = dataJsonArray
      //    .map((userJsonObjectMap) => City.fromJson(userJsonObjectMap))
      //    .toList();
      //return cities;
    }
    return [];
  }
}
