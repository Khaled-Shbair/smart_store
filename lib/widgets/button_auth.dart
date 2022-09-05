import 'package:flutter/material.dart';
import '../widgets/view_details.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';

class ButtonAuth extends StatelessWidget {
  const ButtonAuth({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          double.infinity,
          MediaQuery.of(context).textScaleFactor * 50,
        ),
        primary: ColorsApp.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: ViewDetails(
        data: text,
        fontFamily: FontsApp.fontMedium,
        fontSize: 18,
        color: Colors.white,
      ),
    );
  }
}
