import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';

class InputFiled extends StatelessWidget {
  const InputFiled({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.fontSizeLabel,
    required this.maxLength,
    this.prefixText = '0',
    this.colorLabel = ColorsApp.gery,
    this.fontFamilyLabel = FontsApp.fontRegular,
    this.keyboard = TextInputType.text,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboard;
  final String labelText;
  final String prefixText;
  final IconData prefixIcon;
  final Color colorLabel;
  final String? fontFamilyLabel;
  final double? fontSizeLabel;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      maxLength: maxLength,
      maxLines: 3,
      minLines: 1,
      decoration: InputDecoration(
        labelText: labelText,
        prefixText: prefixText,
        prefixStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        counterText: '',
        prefixIcon: Icon(prefixIcon, color: ColorsApp.green),
        labelStyle: TextStyle(
          fontFamily: fontFamilyLabel,
          color: colorLabel,
          fontSize: fontSizeLabel,
        ),
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
        helperStyle: const TextStyle(color: ColorsApp.gery),
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
