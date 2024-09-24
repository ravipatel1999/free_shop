import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'app_color.dart';

class AppStyles {
  static const double heightInput = 43.0;
  static const double heightBtn = 45.0;
  static const double heightHomeBtn = 40.0;
  static const double heightTopbar = 75.0;

  static const TextStyle loginHeaderStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Color(0xff5F464B),
      fontFamily: 'Poppins');

  static const TextStyle loginMsgStyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xff040415));

  static const TextStyle inputStyle = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff040416));

  static TextStyle inputFloatingStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryColor);

  static const TextStyle btnStyle = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xffffffff));

  static const TextStyle fontStyleNormal = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.primaryColor);

  static const TextStyle fontStyleMedium = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.primaryColor);

  static const TextStyle fontStyleSemiBold = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.primaryColor);

  static const TextStyle btnStyle2 = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff040416));

  static const TextStyle loginText = TextStyle(
      fontSize: 9, fontWeight: FontWeight.w500, color: Color(0xff040416));
}
