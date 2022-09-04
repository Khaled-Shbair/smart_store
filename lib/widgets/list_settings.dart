import '../shared_preferences/pref_controller.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import 'view_details.dart';

class ListSettings extends StatelessWidget {
  const ListSettings({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.backgroundColor,
    this.iconColor = Colors.white,
    required this.title,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Function() onTap;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: backgroundColor,
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: ViewDetails(
        data: title,
        color: PrefController().mode
            ? ColorsApp.colorDarkTheme
            : ColorsApp.geryBold,
        fontFamily: FontsApp.fontLight,
        fontSize: 22,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: PrefController().mode
            ? ColorsApp.colorDarkTheme
            : ColorsApp.geryBold,
      ),
    );
  }
}
