import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';

class PasswordFiled extends StatelessWidget {
  const PasswordFiled({
    Key? key,
    required this.controller,
    required this.keyboard,
    required this.labelText,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.onPressed,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboard;
  final String labelText;
  final bool obscureText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: ColorsApp.green),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(suffixIcon, color: ColorsApp.green),
        ),
        labelStyle: const TextStyle(
          fontFamily: FontsApp.fontRegular,
          color: ColorsApp.gery,
        ),
        helperStyle: const TextStyle(color: ColorsApp.gery),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: ColorsApp.green,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: ColorsApp.green,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: ColorsApp.red),
        ),
      ),
    );
  }
}
