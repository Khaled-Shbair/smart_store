import '../getX/notifications_getX.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../widgets/loading.dart';
import '../widgets/no_data.dart';
import 'package:get/get.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({Key? key}) : super(key: key);
  final NotificationsGetX _notificationsGetX = Get.put(NotificationsGetX());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('notifications'.tr)),
      body: GetX<NotificationsGetX>(
        builder: (controller) {
          if (_notificationsGetX.loading.isTrue) {
            return const Loading();
          }
          return const NoData();
          // TODO: Processing later
          // return listNotifications();
        },
      ),
    );
  }

  Widget listNotifications() {
    if (_notificationsGetX.notification!.data!.isNotEmpty) {
      return const SizedBox();
    } else {
      return const NoData();
    }
  }
}
