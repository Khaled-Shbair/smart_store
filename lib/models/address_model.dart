import 'address.dart';

class AddressModel {
  late bool status;
  late String message;
  List<Address>? data;

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      data = <Address>[];
      json['list'].forEach((v) => data!.add(Address.fromJson(v)));
    }
  }
}
