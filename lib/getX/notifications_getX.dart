import '../shared_preferences/pref_controller.dart';
import '../models/notification_model.dart';
import 'package:http/http.dart' as http;
import '../api/api_paths.dart';
import 'package:get/get.dart';
import 'dart:convert';

class NotificationsGetX extends GetxController {
  static NotificationsGetX get to => Get.find();
  final _notification = Rxn<NotificationModel>();
  RxBool loading = false.obs;

  NotificationModel? get notification => _notification.value;

  set notification(NotificationModel? value) => _notification.value = value;

  @override
  void onInit() {
    super.onInit();
    getNotificationData();
  }

  Future<void> getNotificationData() async {
    loading.value = true;
    var uri = Uri.parse(ApiPath.notifications);
    var response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': PrefController().token,
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      notification = NotificationModel.fromJson(jsonResponse);
      loading.value = false;
    }
  }
}
