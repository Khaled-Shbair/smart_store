class CategoryModel {
  bool? status;
  late String message;
  List<Category>? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
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

class Category {
  late int id;
  late String nameEn;
  late String nameAr;
  late String image;
  late String productsCount;
  late String subCategoriesCount;
  late String imageUrl;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    productsCount = json['products_count'];
    subCategoriesCount = json['sub_categories_count'];
    imageUrl = json['image_url'];
  }
}
