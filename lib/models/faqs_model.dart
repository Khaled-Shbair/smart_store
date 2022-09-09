class FaqsModel {
  late bool status;
  late String message;
  List<Faqs>? data;

  FaqsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      data = <Faqs>[];
      json['list'].forEach((v) => data!.add(Faqs.fromJson(v)));
    }
  }
}

class Faqs {
  Faqs.fromJson(Map<String, dynamic> json) {}
}
