class ProductsOffersModel {
  late bool status;
  late String message;
  List<ProductsOffers>? data;

  ProductsOffersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      data = <ProductsOffers>[];
      json['list'].forEach((v) {
        data!.add(ProductsOffers.fromJson(v));
      });
    }
  }
}

class ProductsOffers {
  late int id;
  late bool expired; //
  late String nameEn;
  late String nameAr;
  late String infoEn;
  late String infoAr;
  late String image;
  late String discountRatio;
  late String originalPrice;
  late String discountPrice;
  late String productId;
  late String startDate;
  late String endDate;
  late String imageUrl;

  ProductsOffers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    infoEn = json['info_en'];
    infoAr = json['info_ar'];
    image = json['image'];
    discountRatio = json['discount_ratio'];
    originalPrice = json['original_price'];
    discountPrice = json['discount_price'];
    productId = json['product_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    expired = json['expired'];
    imageUrl = json['image_url'];
  }
}
