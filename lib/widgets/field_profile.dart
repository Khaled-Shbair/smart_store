import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';
import 'view_details.dart';

class FieldProfile extends StatelessWidget {
  const FieldProfile({
    Key? key,
    required this.title,
    required this.icon,
    this.trailing,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: ColorsApp.green),
      ),
      child: ListTile(
        leading: Icon(icon, color: ColorsApp.green),
        title: ViewDetails(
          data: title,
          fontFamily: FontsApp.fontRegular,
          color: ColorsApp.black,
          fontSize: 24,
        ),
        trailing: trailing,
      ),
    );
  }
}
