import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShortFilterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedSize = 'M'.obs;
  var selectedColor = Colors.black.obs;
  final count = 0.obs;
  late TabController tabController;
  final int tabCount = 5;
  var products = <Product>[
    Product(
      name: "Gildan mens Classic",
      price: 120.0,
      oldPrice: 140.0,
      imageUrl: "assets/Men_Shirts.png",
      rating: 4.5,
      sold: 200,
    ),
    Product(
      name: "Popfunk Classic",
      price: 150.0,
      oldPrice: 169.0,
      imageUrl: "assets/sharess.png",
      rating: 4.5,
      sold: 200,
    ),
    Product(
      name: "Cult T-shirts",
      price: 100.0,
      oldPrice: 116.0,
      imageUrl: "assets/Men_Shirts.png",
      rating: 4.5,
      sold: 200,
    ),
    Product(
      name: "Patchwork T-Shirt Quilts",
      price: 100.0,
      oldPrice: 120.0,
      imageUrl: "assets/Men_Shirts.png",
      rating: 4.5,
      sold: 200,
    ),
    Product(
      name: "Patchwork T-Shirt Quilts",
      price: 100.0,
      oldPrice: 120.0,
      imageUrl: "assets/sharess.png",
      rating: 4.5,
      sold: 200,
    ),
    Product(
      name: "Patchwork T-Shirt Quilts",
      price: 100.0,
      oldPrice: 120.0,
      imageUrl: "assets/Men_Shirts.png",
      rating: 4.5,
      sold: 200,
    ),
    Product(
      name: "Patchwork T-Shirt Quilts",
      price: 100.0,
      oldPrice: 120.0,
      imageUrl: "assets/Men_Shirts.png",
      rating: 4.5,
      sold: 200,
    ),
  ].obs;
  @override
  void onInit() {
    tabController = TabController(length: tabCount, vsync: this);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
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
