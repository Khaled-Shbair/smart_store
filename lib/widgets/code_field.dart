import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CodeField extends StatelessWidget {
  const CodeField({
    Key? key,
    required this.focusNode,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  final FocusNode focusNode;
  final TextEditingController controller;
  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.number,
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        maxLength: 1,
        textAlign: TextAlign.center,
        autofocus: true,
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: ColorsApp.green,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: ColorsApp.green,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: ColorsApp.red),
          ),
        ),
      ),
    );
  }
}
