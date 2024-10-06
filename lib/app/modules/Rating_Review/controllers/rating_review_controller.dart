import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingReviewController extends GetxController {
  var selectedIndex = (-1).obs;
  var selectedValue = 'Most Recent'.obs;

  void setSelectedValue(String value) {
    selectedValue.value = value;
  }

  final count = 0.obs;
  final List<Map<String, dynamic>> categories = [
    {'name': 'All', 'count': 255, 'icon': null},
    {'name': 'Camera Photos', 'count': 140, 'icon': Icons.camera_alt},
    {'name': 'Good Product', 'count': 389, 'icon': null},
  ];
  final List<Map<String, dynamic>> ratingcategories = [
    {'count': 5, 'total': '80'},
    {'count': 4, 'total': '70'},
    {'count': 5, 'total': '90'},
    {'count': 8, 'total': '62'},
    {'count': 5, 'total': '80'},
    {'count': 4, 'total': '70'},
    {'count': 5, 'total': '90'},
    {'count': 8, 'total': '62'},
  ];
  var likeCount = 2.obs;
  var dislikeCount = 1.obs;

  void incrementLike() {
    likeCount++;
  }

  void incrementDislike() {
    dislikeCount++;
  }

  var reviews = [
    {
      'userName': 'Robert Fox',
      'userImage': 'assets/Men_Shirts.png',
      'rating': 3,
      'reviewText':
          'The item just arrived! Can\'t wait to try it this week. Hope it suits my style!',
      'reviewImages': [
        'assets/Men_Shirts.png',
        'assets/Men_Shirts.png',
        'assets/Men_Shirts.png',
      ]
    },
    {
      'userName': 'Henry Jonson',
      'userImage': 'assets/Men_Shirts.png',
      'rating': 4,
      'reviewText':
          'Urban Blend shirt is a versatile addition. Slightly snug but stylish and well-made.',
      'reviewImages': [
        'assets/Men_Shirts.png',
        'assets/Men_Shirts.png',
        'assets/Men_Shirts.png',
      ]
    }
  ].obs; // observable list
  void selectCategory(int index) {
    selectedIndex.value = index;
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
