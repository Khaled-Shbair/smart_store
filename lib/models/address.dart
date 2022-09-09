import 'city.dart';

class Address {
  late int id;
  late String name;
  late String info;
  late String contactNumber;
  String? lat;
  String? lang;
  late int cityId;
  late City city;

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    info = json['info'];
    contactNumber = json['contact_number'];
    lat = json['lat'];
    lang = json['lang'];
    cityId = json['city_id'];
    city = City.fromJson(json['city']);
  }
}
