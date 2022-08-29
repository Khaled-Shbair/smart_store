import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';

class PasswordFiled extends StatelessWidget {
  const PasswordFiled({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.onPressed,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: ColorsApp.green,
        ),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: ColorsApp.green,
          ),
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
