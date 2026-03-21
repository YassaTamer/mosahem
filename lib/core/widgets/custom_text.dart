import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    this.fontFamily,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.underline = false,
    this.decorationColor,
    this.decorationThickness,
  });
  final String text;
  final String? fontFamily;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? underline;
  final Color? decorationColor;
  final double? decorationThickness;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: underline == true ? TextDecoration.underline : null,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness,
      ),
    );
  }
}
