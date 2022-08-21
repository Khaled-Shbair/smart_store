import 'city_model.dart';

class UserModel {
  late bool status;
  late String message;
  User? data;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }
}

class User {
  late int id;
  late String name;
  String? email;
  late String mobile;
  late String gender;
  late bool active;
  late bool verified;
  late String cityId;
  late String storeId;
  String? fcmToken;
  late String token;
  late String tokenType;
  late String refreshToken;
  City? city;
  Store? store;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    active = json['active'];
    verified = json['verified'];
    cityId = json['city_id'];
    storeId = json['store_id'];
    fcmToken = json['fcm_token'];
    token = json['token'];
    tokenType = json['token_type'];
    refreshToken = json['refresh_token'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
  }
}

class Store {
  late int id;
  late String name;
  late String storeName;
  late String email;
  dynamic emailVerifiedAt;
  late String mobile;
  late String storeUuid;
  late String cityId;
  dynamic verificationCode;
  late String active;
  late String verified;
  late String firebaseKey;
  String? image;
  late String address;
  dynamic facebook;
  dynamic instagram;
  late String createdAt;
  late String updatedAt;

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    storeName = json['store_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobile = json['mobile'];
    storeUuid = json['store_uuid'];
    cityId = json['city_id'];
    verificationCode = json['verification_code'];
    active = json['active'];
    verified = json['verified'];
    firebaseKey = json['firebase_key'];
    image = json['image'];
    address = json['address'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
