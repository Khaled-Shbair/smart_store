import 'category.dart';

class SubCategoryModel {
  late bool status;
  late String message;
  List<Category>? data;

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      data = <Category>[];
      json['list'].forEach((v) {
        data!.add(Category.fromJson(v));
      });
    }
  }
}
/*
class SubCategory {
  late int id;
  late String nameEn;
  late String nameAr;
  late String image;
  late String imageUrl;
  late String productsCount;
  late String categoryId;

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    categoryId = json['category_id'];
    image = json['image'];
    productsCount = json['products_count'];
    imageUrl = json['image_url'];
  }
}
*/