import 'package:flutter/material.dart';

import '../constants/fonts.dart';

PreferredSizeWidget appBarApp({required String title}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontFamily: FontsApp.fontBold,
        color: Color(0XFF0EBE7F),
      ),
    ),
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}
