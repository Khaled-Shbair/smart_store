import 'product.dart';

class FavoriteProductsModel {
  late bool status;
  late String message;
  List<Products>? data;

  FavoriteProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      data = <Products>[];
      json['list'].forEach((v) => data!.add(Products.fromJson(v)));
    }
  }
}
