import 'payment_model.dart';
import 'address.dart';
import 'product.dart';

class OrdersModel {
  late bool status;
  late String message;
  List<Order>? data;

  OrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      data = <Order>[];
      json['list'].forEach((v) => data!.add(Order.fromJson(v)));
    }
  }
}

class Order {
  late int id;
  late String total;
  late String date;
  late String paymentType;
  late String status;
  late String storeId;
  late String userId;
  late String addressId;
  late String paymentCardId;
  String? orderProductsCount;
  String? productsCount;
  List<Products>? products;
  List<Address>? address;
  List<Payment>? payment;

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    paymentType = json['payment_type'];
    status = json['status'];
    storeId = json['store_id'];
    userId = json['user_id'];
    addressId = json['address_id'];
    paymentCardId = json['payment_card_id'];
    orderProductsCount = json['order_products_count'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) => address!.add(Address.fromJson(v)));
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) => products!.add(Products.fromJson(v)));
    }
    if (json['payment_card'] != null) {
      payment = <Payment>[];
      json['payment_card'].forEach((v) => payment!.add(Payment.fromJson(v)));
    }
  }
}
