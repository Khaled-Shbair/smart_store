import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../widgets/no_data.dart';
import '../widgets/view_details.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.scaffoldColor,
      appBar: AppBar(
        title: ViewDetails(
          data:'notifications'.tr,
          fontFamily: FontsApp.fontBold,
          color: ColorsApp.green,
          fontSize: 24,
        ),
        iconTheme: const IconThemeData(color: ColorsApp.green),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const NoData(),
    );
  }
}
