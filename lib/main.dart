import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/components/TextField/constant/app_color.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Trend Mart",
      initialRoute: AppPages.INITIAL,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.whiteColor,
          surfaceTintColor: AppColors.whiteColor,
        ),
      ),
    ),
  );
}

class ResponsiveHelper {
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  static double getFontSize(BuildContext context, double mobileFontSize) {
    if (isTablet(context)) {
      return mobileFontSize * 1.5;
    }
    return mobileFontSize;
  }

  static double getContainerSize(BuildContext context, double mobileSize) {
    if (isTablet(context)) {
      return mobileSize * 1.5;
    }
    return mobileSize;
  }
}
