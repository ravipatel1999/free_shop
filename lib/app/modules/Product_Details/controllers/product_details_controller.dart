import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/TextField/constant/app_color.dart';

class ProductDetailsController extends GetxController {
  var selectedSize = 'M'.obs;
  var selectedColor = Colors.black.obs;
  final count = 0.obs;
  var imagePaths = <String>[
    'assets/Men_Shirts.png',
    'assets/Men_Shirts.png',
    'assets/Men_Shirts.png',
  ].obs;

  var vouchers = <String>[
    '20% OFF',
    '15% OFF',
    '10% OFF',
    '5% OFF',
  ].obs;
  var productInfo = [
    {'label': 'Material', 'value': '100% Acrylic'},
    {'label': 'SKU', 'value': 'UBL-SS-S5-C6-245'},
    {'label': 'Pattern', 'value': 'Solid'},
  ].obs; // Make it observable

  var products = <Product>[
    Product(
      name: "Gildan mens Classic",
      price: 120.0,
      oldPrice: 140.0,
      imageUrl: 'assets/Men_Shirts.png',
      rating: 4.5,
      sold: 200,
    ),
    Product(
      name: "Popfunk Classic",
      price: 150.0,
      oldPrice: 169.0,
      imageUrl: 'assets/Men_Shirts.png',
      rating: 4.5,
      sold: 200,
    ),
    Product(
      name: "Cult T-shirts",
      price: 100.0,
      oldPrice: 116.0,
      imageUrl: 'assets/Men_Shirts.png',
      rating: 4.5,
      sold: 200,
    ),
    Product(
      name: "Patchwork T-Shirt Quilts",
      price: 100.0,
      oldPrice: 120.0,
      imageUrl: 'assets/Men_Shirts.png',
      rating: 4.5,
      sold: 200,
    ),
    Product(
      name: "Patchwork T-Shirt Quilts",
      price: 100.0,
      oldPrice: 120.0,
      imageUrl: 'assets/Men_Shirts.png',
      rating: 4.5,
      sold: 200,
    ),
    Product(
      name: "Patchwork T-Shirt Quilts",
      price: 100.0,
      oldPrice: 120.0,
      imageUrl: 'assets/Men_Shirts.png',
      rating: 4.5,
      sold: 200,
    ),
    Product(
      name: "Patchwork T-Shirt Quilts",
      price: 100.0,
      oldPrice: 120.0,
      imageUrl: 'assets/Men_Shirts.png',
      rating: 4.5,
      sold: 200,
    ),
  ].obs;

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

class Product {
  final String name;
  final double price;
  final double? oldPrice;
  final String imageUrl;
  final double rating;
  final int sold;

  Product({
    required this.name,
    required this.price,
    this.oldPrice,
    required this.imageUrl,
    required this.rating,
    required this.sold,
  });
}
