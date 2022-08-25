class ProductCategoryModel {
  late bool status;
  late String message;
  List<ProductCategory>? data;

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      data = <ProductCategory>[];
      json['list'].forEach((v) {
        data!.add(ProductCategory.fromJson(v));
      });
    }
  }
}

class ProductCategory {
  late int id;
  late String nameEn;
  late String nameAr;
  late String infoEn;
  late String infoAr;
  late dynamic price;
  late dynamic quantity;
  late dynamic overalRate;
  late dynamic subCategoryId;
  late dynamic productRate;
  late dynamic offerPrice;
  late bool isFavorite;
  late String imageUrl;

  ProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    infoEn = json['info_en'];
    infoAr = json['info_ar'];
    price = json['price'];
    quantity = json['quantity'];
    overalRate = json['overal_rate'];
    subCategoryId = json['sub_category_id'];
    productRate = json['product_rate'];
    offerPrice = json['offer_price'];
    isFavorite = json['is_favorite'];
    imageUrl = json['image_url'];
  }
}
