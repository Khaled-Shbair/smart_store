import 'package:flutter/material.dart';

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
        counterText: '',
        prefixIcon: Icon(prefixIcon, color: const Color(0XFF0EBE7F)),
        labelStyle: const TextStyle(
            fontFamily: FontsApp.fontRegular, color: Color(0XFF677294)),
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
        helperStyle: const TextStyle(color: Colors.grey),
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
