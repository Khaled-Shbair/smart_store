import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import 'package:get/get.dart';
import 'view_details.dart';

class NoData extends StatelessWidget {
  const NoData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning,
            size: 84,
            color: ColorsApp.green,
          ),
          ViewDetails(
            data: 'no_data'.tr,
            fontFamily: FontsApp.fontMedium,
            fontSize: 30,
            color: ColorsApp.green,
          ),
        ],
      ),
    );
  }
}
