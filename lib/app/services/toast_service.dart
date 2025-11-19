import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ApptoastUtils {
  static void showSuccess(String message) {
    _showCustomToast(
      message: message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  static void showError(String message) {
    _showCustomToast(
      message: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  static void showWarning(String message) {
    _showCustomToast(
      message: message,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
    );
  }

  static void showInfo(String message) {
    _showCustomToast(
      message: message,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }

  // Custom color toast (your original method)
  static void showToastUtil(String msg, Color toastBg) {
    _showCustomToast(
      message: msg,
      backgroundColor: toastBg,
      textColor: Colors.white,
    );
  }

  // Toast with custom position
  static void showTopToast(String message,
      {Color backgroundColor = Colors.black87}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showCenterToast(String message,
      {Color backgroundColor = Colors.black87}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showBottomToast(String message,
      {Color backgroundColor = Colors.black87}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Toast with different durations
  static void showLongToast(String message,
      {Color backgroundColor = Colors.black87}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showShortToast(String message,
      {Color backgroundColor = Colors.black87}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showCustomToast({
    required String message,
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    double fontSize = 16.0,
    int timeInSecForIosWeb = 1,
    bool webShowClose = false,
    Color webBgColor = Colors.black,
    String webPosition = "right",
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
      webShowClose: webShowClose,
      webBgColor: webBgColor,
      webPosition: webPosition,
    );
  }

  static void showGetXSnackbar({
    required String title,
    required String message,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
    SnackPosition snackPosition = SnackPosition.TOP,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: textColor,
      duration: duration,
      snackPosition: snackPosition,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
    );
  }

  static void showGetXSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  static void showGetXError(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  static void cancelAllToasts() {
    Fluttertoast.cancel();
  }

  static void _showCustomToast({
    required String message,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Toast length = Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
}
