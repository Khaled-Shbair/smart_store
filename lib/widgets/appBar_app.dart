import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';

PreferredSizeWidget appBarApp({required String title}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontFamily: FontsApp.fontBold,
        color: ColorsApp.green,
        fontSize: 24,
      ),
    ),
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}
