import 'city.dart';

class CityModel {
  late bool status;
  late String message;
  late List<City> list;

  CityModel.fromJson(Map<String, dynamic> json) {
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
