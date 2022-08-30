import 'product.dart';

class ProductDetailsModel {
  late bool status;
  late String message;
  Products? data;

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['object'] != null ? Products.fromJson(json['object']) : null;
  }
}

class Images {
  late int id;
  late String objectId;
  late String url;
  late String imageUrl;

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    objectId = json['object_id'];
    url = json['url'];
    imageUrl = json['image_url'];
  }
}
