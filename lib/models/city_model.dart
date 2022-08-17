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

class City {
  late int id;
  late String nameEn;
  late String nameAr;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }
}
