import 'package:smart_store/models/cities/city.dart';

class CitiesResponse {
  late bool status;
  late String message;
  late List<City> list;

  CitiesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      list = <City>[];
      json['list'].forEach((v) {
        list.add(City.fromJson(v));
      });
    }
  }
}
