import 'product.dart';

class ProductCategoryModel {
  late bool status;
  late String message;
  List<Products>? data;

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
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
