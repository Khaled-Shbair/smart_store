class OrdersModel {
  late bool status;
  late String message;
  List<Order>? data;

  OrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      data = <Order>[];
      json['list'].forEach((v) {
        data!.add(Order.fromJson(v));
      });
    }
  }
}

class Order {
  Order.fromJson(Map<String, dynamic> json) {}
}
