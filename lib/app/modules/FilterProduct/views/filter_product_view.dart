import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/filter_product_controller.dart';

class FilterProductView extends GetView<FilterProductController> {
  const FilterProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FilterProductView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FilterProductView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
