import '../shared_preferences/pref_controller.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';

class ChooseGender extends StatelessWidget {
  const ChooseGender({
    Key? key,
    required this.groupValue,
    required this.value,
    required this.title,
    required this.onChanged,
  }) : super(key: key);
  final String groupValue;
  final String value;
  final String title;
  final Function(String? newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RadioListTile<String>(
        title: Text(
          title,
          style: TextStyle(
            color: PrefController().mode
                ? ColorsApp.colorDarkTheme
                : ColorsApp.black,
            fontFamily: FontsApp.fontRegular,
            fontSize: MediaQuery.of(context).textScaleFactor * 20,
          ),
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
