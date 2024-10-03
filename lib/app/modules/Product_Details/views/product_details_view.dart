import 'package:eccomerce_app/app/components/TextField/constant/app_color.dart';
import 'package:eccomerce_app/app/custom/imagecustom.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            size: 30,
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomImageView(
                  imagePath: 'assets/Men_Shirts.png',
                  height: 250,
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gildan mens Classic',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 16),
                            SizedBox(width: 4),
                            Text('4.5 (64) . 200 sold'),
                            Spacer(),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text(
                              '\$120.00',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '\$140.00',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Available Vouchers'),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        _voucherCard('20% OFF'),
                        const SizedBox(width: 8.0),
                        _voucherCard('15% OFF'),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Size'),
                    const SizedBox(height: 8.0),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ['XXS', 'XS', 'S', 'M', 'L', 'XL']
                            .map((size) => GestureDetector(
                                  onTap: () =>
                                      controller.selectedSize.value = size,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: controller.selectedSize.value ==
                                                size
                                            ? AppColors.primaryColor
                                            : Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(size),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Colour'),
                    const SizedBox(height: 8.0),
                    Obx(
                      () => Row(
                        children: [
                          AppColors.primaryColor,
                          Colors.grey,
                          Colors.red,
                          Colors.pink,
                          Colors.blue,
                          Colors.purple
                        ]
                            .map(
                              (color) => GestureDetector(
                                onTap: () =>
                                    controller.selectedColor.value = color,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: color,
                                    border: Border.all(
                                      color: controller.selectedColor.value ==
                                              color
                                          ? AppColors.primaryColor
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Product Information',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8.0),
                    _productInfoRow('Material', '100% Acrylic'),
                    _productInfoRow('SKU', 'UBL-SS-S5-C6-245'),
                    _productInfoRow('Pattern', 'Solid'),
                    const SizedBox(height: 16.0),
                    Text(
                      'Elevate your style with the Urban Blend Long Sleeve Shirt, a perfect blend of urban sophistication and contemporary comfort...',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 16.0),
                    const Divider(),
                    _reviewsSection(),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Buy Now'),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: const Text('Add to Cart'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _voucherCard(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(text),
    );
  }

  Widget _productInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _reviewsSection() {
    final List<double> reviewRatings = [0.7, 0.5, 0.3, 0.2, 0.1];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Rating & Reviews',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Text(
              '4.8',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(5, (index) {
                  return Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      const SizedBox(width: 4.0),
                      Text('${5 - index}'),
                      const SizedBox(width: 4.0),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: reviewRatings[index],
                          minHeight: 4.0,
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text('${(reviewRatings[index] * 100).toInt()}%'),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _reviewCard('Robert Fox', 3,
            'The item just arrived! Can\'t wait to try it this week.'),
        _reviewCard('Henry Jonson', 4,
            'Urban Blend shirt is a versatile addition. Slightly snug but stylish.'),
      ],
    );
  }

  Widget _reviewCard(String name, int rating, String review) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.orange,
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(review),
        ],
      ),
    );
  }
}
