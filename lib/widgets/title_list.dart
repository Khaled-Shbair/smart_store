import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view_details.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';

class TitleList extends StatelessWidget {
  const TitleList({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ViewDetails(
          data: title,
          fontFamily: FontsApp.fontMedium,
          fontSize: 20,
          color: ColorsApp.green,
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsetsDirectional.zero,
            elevation: 0,
            primary: Colors.transparent,
          ),
          child: ViewDetails(
            data: 'see_all'.tr,
            fontFamily: FontsApp.fontRegular,
            fontSize: 18,
            color: ColorsApp.green,
          ),
        ),
      ],
    );
  }
}
