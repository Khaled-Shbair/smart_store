import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';

class InputFiled extends StatelessWidget {
  const InputFiled({
    Key? key,
    required this.controller,
    required this.keyboard,
    required this.labelText,
    required this.prefixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboard;
  final String labelText;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      maxLength: 9,
      decoration: InputDecoration(
        labelText: labelText,
        prefixText: '0',
        prefixStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        counterText: '',
        prefixIcon: Icon(prefixIcon, color: MyColors.green),
        labelStyle: const TextStyle(
          fontFamily: FontsApp.fontRegular,
          color: MyColors.gery,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: MyColors.green,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: MyColors.green,
          ),
        ),
        helperStyle: const TextStyle(color: MyColors.gery),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: MyColors.red),
        ),
      ),
    );
  }
}
