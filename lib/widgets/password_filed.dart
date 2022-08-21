import 'package:flutter/material.dart';

class PasswordFiled extends StatelessWidget {
  const PasswordFiled({
    Key? key,
    required this.controller,
    required this.keyboard,
    required this.hintText,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.onPressed,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboard;
  final String hintText;
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
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(suffixIcon),
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
