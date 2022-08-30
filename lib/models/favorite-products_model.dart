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
      json['list'].forEach((v) {
        data!.add(Products.fromJson(v));
      });
    }
  }
}

class Pivot {
  late String userId;
  late String productId;

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    productId = json['product_id'];
  }
}
