import 'package:flutter/material.dart';

class ViewDetails extends StatelessWidget {
  const ViewDetails({
    Key? key,
    required this.data,
    this.fontSize = 26,
    this.color = Colors.red,
    this.fontWeight,
    this.height,
    this.decoration,
    this.decorationThickness,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.fontFamily,
  }) : super(key: key);

  final String data;
  final double fontSize;
  final Color color;
  final FontWeight? fontWeight;
  final double? height;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final double? decorationThickness;
  final int? maxLines;
  final TextAlign? textAlign;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: fontFamily,
        overflow: overflow,
        height: height,
        fontSize: MediaQuery.of(context).textScaleFactor * fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationThickness: decorationThickness,
      ),
    );
  }
}
