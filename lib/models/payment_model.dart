class PaymentModel {
  late bool status;
  late String message;
  List<Payment>? date;

  PaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      date = <Payment>[];
      json['list'].forEach((v) => date!.add(Payment.fromJson(v)));
    }
  }
}

class Payment {
  late int id;
  late String holderName;
  late String cardNumber;
  late String expDate;
  late String cvv;
  late String type;
  late String updatedAt;
  late String createdAt;
  late String userId;

  Payment.fromJson(Map<String, dynamic> json) {
    holderName = json['holder_name'];
    cardNumber = json['card_number'];
    expDate = json['exp_date'];
    cvv = json['cvv'];
    type = json['type'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}
