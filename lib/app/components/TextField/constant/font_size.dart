import 'package:flutter/material.dart';

class CustomTextStyle {
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;

  CustomTextStyle({
    this.fontSize,
    this.color,
    this.fontWeight,
  });

  TextStyle get style {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }
}
