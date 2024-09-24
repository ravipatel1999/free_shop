import 'package:eccomerce_app/app/components/TextField/constant/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.whiteColor,
            surfaceTintColor: AppColors.whiteColor),
      ),
    ),
  );
}
