import 'category.dart';
import 'product.dart';

class HomeModel {
  bool? status;
  late String message;
  Data? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Slider>? slider;
  List<Category>? categories;
  List<Products>? latestProducts;
  List<Products>? famousProducts;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['slider'] != null) {
      slider = <Slider>[];
      json['slider'].forEach((v) {
        slider!.add(Slider.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }

    if (json['latest_products'] != null) {
      latestProducts = <Products>[];
      json['latest_products'].forEach((v) {
        latestProducts!.add(Products.fromJson(v));
      });
    }
    if (json['famous_products'] != null) {
      famousProducts = <Products>[];
      json['famous_products'].forEach((v) {
        famousProducts!.add(Products.fromJson(v));
      });
    }
  }
}

class Slider {
  late int id;
  late String objectId;
  late String url;
  late String imageUrl;

  Slider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    objectId = json['object_id'];
    url = json['url'];
    imageUrl = json['image_url'];
  }
}
