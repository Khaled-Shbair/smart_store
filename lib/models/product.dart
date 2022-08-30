import 'favorite-products_model.dart';
import 'product_details_model.dart';

class Products {
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
   Pivot? pivot;
   List<Images>? images;


  Products.fromJson(Map<String, dynamic> json) {
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
    pivot =json['pivot']!=null? Pivot.fromJson(json['pivot']):null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }
}
