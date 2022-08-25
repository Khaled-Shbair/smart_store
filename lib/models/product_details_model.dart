class ProductDetailsModel {
  late bool status;
  late String message;
  ProductDetails? data;

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['object'] != null ? ProductDetails.fromJson(json['object']) : null;
  }
}

class ProductDetails {
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
  List<Images>? images;

  ProductDetails.fromJson(Map<String, dynamic> json) {
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
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
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
