import 'package:eccomerce_app/app/core/theme/summer_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import '../TextField/constant/app_color.dart';

class AppStyles {
  static const double heightInput = 43.0;
  static const double heightBtn = 45.0;
  static const double heightHomeBtn = 40.0;
  static const double heightTopbar = 75.0;

  static const TextStyle loginHeaderStyle = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.carbonColor,
      fontFamily: 'Poppins');

  static const TextStyle headerStyle = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    color: AppColors.carbonColor,
  );

  static const TextStyle loginMsgStyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xff040415));

  static const TextStyle inputStyle = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff040416));

  static TextStyle inputFloatingStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryColor);

  static TextStyle btnStyle = SummerTextStyle.buttonLarge;

  static const TextStyle appBarStyle = TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xffffffff));

  static const TextStyle btnStyle14 = TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff000000));

  static const TextStyle fontStyleNormal = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.primaryColor);

  static const TextStyle fontStyleMedium = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.primaryColor);

  static const TextStyle fontStyleSemiBold = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor);

  static const TextStyle fontStyleSemiNormal = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.primaryColor);

  static const TextStyle btnStyle2 = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff040416));

  static const TextStyle loginText = TextStyle(
      fontSize: 9, fontWeight: FontWeight.w500, color: Color(0xff040416));

  static const TextStyle captionsText = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(147, 0, 0, 0),
  );
}
