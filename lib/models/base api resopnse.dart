import 'package:smart_store/models/user.dart';

class BaseApiResponse {
  late bool status;
  late String message;
  late List<User> data;

  BaseApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <User>[];
      json['data'].forEach((v) {
        data.add(User.fromJson(v));
      });
    }
  }
}
