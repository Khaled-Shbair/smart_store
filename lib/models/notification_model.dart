class NotificationModel {
  late bool status;
  late String message;
  List<Notification>? data;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      data = <Notification>[];
      json['list'].forEach((v) {
        data!.add(Notification.fromJson(v));
      });
    }
  }
}

class Notification {
  Notification.fromJson(Map<String, dynamic> json) {}
}
