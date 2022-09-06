import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';

class SelectCity extends StatelessWidget {
  const SelectCity({
    Key? key,
    required this.onChanged,
    required this.items,
    required this.selected,
  }) : super(key: key);

  final String selected;
  final Function(String? value) onChanged;
  final List<DropdownMenuItem<String>>? items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: ColorsApp.green),
      ),
      child: DropdownButton<String>(
        borderRadius: BorderRadius.circular(20),
        iconEnabledColor: ColorsApp.green,
        dropdownColor: ColorsApp.green,
        underline: const Text(''),
        style: const TextStyle(
          fontFamily: FontsApp.fontMedium,
          fontSize: 20,
          color: ColorsApp.black,
        ),
        menuMaxHeight: 228,
        isExpanded: true,
        iconSize: 40,
        hint: Text(selected),
        onChanged: onChanged,
        items: items,
      ),
    );
  }
}
