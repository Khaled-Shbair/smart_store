class PaymentModel {
  late bool status;
  late String message;
  Payment? payment;

  PaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    payment = json['object'] != null ? Payment.fromJson(json['object']) : null;
  }
}

class Payment {
  late String holderName;
  late String cardNumber;
  late String expDate;
  late String cvv;
  late String type;
  late String updatedAt;
  late String createdAt;
  late int id;
  late int userId;

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
