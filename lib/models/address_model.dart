class AddressModel {
  late bool status;
  late String message;
  List<Address>? data;

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      data = <Address>[];
      json['list'].forEach((v) {
        data!.add(Address.fromJson(v));
      });
    }
  }
}

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
