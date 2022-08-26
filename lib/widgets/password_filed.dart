import 'package:flutter/material.dart';

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
        prefixIcon: Icon(prefixIcon,color: const Color(0XFF0EBE7F)),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(suffixIcon, color: const Color(0XFF0EBE7F)),
        ),
        labelStyle: const TextStyle(
          fontFamily: FontsApp.fontRegular,
          color: Color(0XFF677294),
        ),
        helperStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: Color(0XFF0EBE7F),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: Color(0XFF0EBE7F),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
