import 'category.dart';

class CategoryModel {
  bool? status;
  late String message;
  List<Category>? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      data = <Category>[];
      json['list'].forEach((v) => data!.add(Category.fromJson(v)));
    }
  }
}
