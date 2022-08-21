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
  late List<Slider> slider;
  late List<Categories> categories;
  late List<LatestProducts> latestProducts;
  late List<FamousProducts> famousProducts;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['slider'] != null) {
      slider = <Slider>[];
      json['slider'].forEach((v) {
        slider.add(Slider.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(Categories.fromJson(v));
      });
    }
    if (json['latest_products'] != null) {
      latestProducts = <LatestProducts>[];
      json['latest_products'].forEach((v) {
        latestProducts.add(LatestProducts.fromJson(v));
      });
    }
    if (json['famous_products'] != null) {
      famousProducts = <FamousProducts>[];
      json['famous_products'].forEach((v) {
        famousProducts.add(FamousProducts.fromJson(v));
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

class Categories {
  late int id;
  late String nameEn;
  late String nameAr;
  late String image;
  late String imageUrl;

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    imageUrl = json['image_url'];
  }
}

class LatestProducts {
  late int id;
  late String nameEn;
  late String nameAr;
  late String infoEn;
  late String infoAr;
  late String price;
  late String quantity;
  late String overalRate;
  late String subCategoryId;
  late int productRate;
  late String offerPrice;
  late bool isFavorite;
  late String imageUrl;

  LatestProducts.fromJson(Map<String, dynamic> json) {
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

class FamousProducts {
  late int id;
  late String nameEn;
  late String nameAr;
  late String infoEn;
  late String infoAr;
  late String price;
  late String quantity;
  late String overalRate;
  late String subCategoryId;
  late int productRate;
  late dynamic offerPrice;
  late bool isFavorite;
  late String imageUrl;

  FamousProducts.fromJson(Map<String, dynamic> json) {
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
