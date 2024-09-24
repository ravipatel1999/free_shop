import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBordingController extends GetxController {
  //TODO: Implement OnBordingController

  final count = 0.obs;

  final pageController = PageController();
  var currentPage = 0.obs;

  void nextPage() {
    if (currentPage.value < 2) {
      currentPage.value++;
    } else {
      currentPage.value = 0;
    }
    pageController.animateToPage(
      currentPage.value,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
