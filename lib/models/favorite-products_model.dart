class FavoriteProductsModel {
  late bool status;
  late String message;
  List<FavoriteProducts>? data;

  FavoriteProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      data = <FavoriteProducts>[];
      json['list'].forEach((v) {
        data!.add(FavoriteProducts.fromJson(v));
      });
    }
  }
}

class FavoriteProducts {
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
  late Pivot pivot;

  FavoriteProducts.fromJson(Map<String, dynamic> json) {
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
    pivot = Pivot.fromJson(json['pivot']);
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
