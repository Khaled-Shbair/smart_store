import 'dart:convert';
import 'package:smart_store/api/api%20paths.dart';
import 'package:http/http.dart' as http;
import '../../models/cities/cities response.dart';
import '../../models/cities/city.dart';

class CitiesApiController {
  Future<List<City>> readCities() async {
    var httpUri = Uri.parse(ApiPath.cities);
    var response = await http.get(httpUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      CitiesResponse citiesResponse = CitiesResponse.fromJson(jsonResponse);
      return citiesResponse.list;
     // var dataJsonArray = jsonResponse['list'] as List;
     // List<City> cities = dataJsonArray
     //     .map((userJsonObjectMap) => City.fromJson(userJsonObjectMap))
     //     .toList();
     // return cities;
    }
    return [];
  }

}
