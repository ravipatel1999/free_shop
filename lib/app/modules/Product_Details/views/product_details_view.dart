import 'dart:ui';

import 'package:eccomerce_app/app/components/TextField/constant/app_color.dart';
import 'package:eccomerce_app/app/components/testStyle/input_Style.dart';
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('Product Details'),
        centerTitle: true,
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
              _imageGallery(context),
              const SizedBox(height: 16.0),
              Align(alignment: Alignment.topCenter, child: _buildDot(true)),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Gildan mens Classic',
                          style: AppStyles.headerStyle,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 0.5, color: AppColors.primaryColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Iconsax.heart,
                                size: 15,
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(Icons.star, color: AppColors.hintColor, size: 16),
                        SizedBox(width: 4),
                        Text('4.5 (64) * 200 Sold'),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    const Row(
                      children: [
                        Text(
                          '\$120.00',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '\$140.00',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.hintColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Available Vouchers',
                          style: AppStyles.fontStyleSemiBold,
                        ),
                        const Text(
                          'View All',
                          style: AppStyles.btnStyle14,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Obx(() {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: controller.vouchers
                              .map((text) => Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: _voucherCard('Best Deal: $text'),
                                  ))
                              .toList(),
                        ),
                      );
                    }),
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
                                      color:
                                          controller.selectedSize.value == size
                                              ? Colors.black
                                              : Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(
                                      size,
                                      style: TextStyle(
                                        color: controller.selectedSize.value ==
                                                size
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Colors.black,
                          Colors.yellow,
                          Colors.red,
                          Colors.pink,
                          Colors.blue,
                          Colors.purple,
                        ].map((color) {
                          bool isSelected =
                              controller.selectedColor.value == color;
                          return GestureDetector(
                            onTap: () => controller.selectedColor.value = color,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              height: 32,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: color,
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    )
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Product Information',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8.0),
                    Column(
                      children: controller.vouchers
                          .map((text) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child:
                                    _productInfoRow('Material', '100% Acrylic'),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Elevate your style with the Urban Blend Long Sleeve Shirt, a perfect blend of urban sophistication and contemporary comfort...',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 16.0),
                    const Divider(),
                    _reviewsSection(),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 100))
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(color: AppColors.whiteColor),
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.carbonColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(Iconsax.message)),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 4,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.carbonColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      'Buy Now',
                      style: AppStyles.appBarStyle,
                    )),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 4,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.carbonColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      'Add to Cart',
                      style: AppStyles.btnStyle14,
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageGallery(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        itemCount: controller.imagePaths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _showImageDialog(context, index),
            child: Image.asset(
              controller.imagePaths[index],
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }

  void _showImageDialog(BuildContext context, int initialIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            int currentIndex = initialIndex;
            PageController pageController =
                PageController(initialPage: currentIndex);

            double dialogHeight = MediaQuery.of(context).size.height * 0.7;

            return Dialog(
              child: Container(
                decoration: BoxDecoration(color: AppColors.whiteColor),
                height: dialogHeight,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: pageController,
                      itemCount: controller.imagePaths.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Center(
                          child: Image.asset(
                            controller.imagePaths[index],
                            fit: BoxFit.contain,
                            height: dialogHeight,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      right: 16,
                      top: 16,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primaryColor)),
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 20,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: dialogHeight / 2 - 24,
                      child: IconButton(
                        icon: Icon(Iconsax.arrow_square_left,
                            size: 30, color: AppColors.primaryColor),
                        onPressed: () {
                          setState(() {
                            if (currentIndex > 0) {
                              currentIndex--;
                              pageController.animateToPage(
                                currentIndex,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          });
                        },
                      ),
                    ),
                    Positioned(
                      right: 16,
                      top: dialogHeight / 2 - 24,
                      child: IconButton(
                        icon: Icon(Iconsax.arrow_right,
                            size: 30, color: AppColors.primaryColor),
                        onPressed: () {
                          setState(() {
                            if (currentIndex <
                                controller.imagePaths.length - 1) {
                              currentIndex++;
                              pageController.animateToPage(
                                currentIndex,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _voucherCard(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Iconsax.discount_shape,
                    size: 25,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(text, style: AppStyles.inputFloatingStyle),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'Min spend \$150  •  Valid til 12/12/2024',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _productInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('  :  '),
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
                      const Icon(Icons.star,
                          color: AppColors.hintColor, size: 16),
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
        Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.reviews.length,
              itemBuilder: (context, index) {
                final review = controller.reviews[index];
                return _reviewCard(
                  review['userName'] as String,
                  review['userImage'] as String,
                  review['rating'] as int,
                  review['reviewText'] as String,
                  List<String>.from(review['reviewImages'] as List),
                );
              },
            )),
      ],
    );
  }

  Widget _reviewCard(String userName, String userImage, int rating,
      String reviewText, List<String> reviewImages) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.hintColor),
          borderRadius: BorderRadius.circular(9)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 232, 232, 232),
                  child: CustomImageView(
                    imagePath: 'assets/Men_Shirts.png',
                  ),
                ),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('2 days ago'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: AppColors.hintColor,
                      size: 16,
                    );
                  }),
                ),
                Text('  3 stars')
              ],
            ),
            const SizedBox(height: 8.0),
            Text(reviewText),
            const SizedBox(height: 8.0),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: reviewImages.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: CustomImageView(
                    imagePath: reviewImages[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 16 : 8, // Elongate the active dot
      height: 8, // Keep height consistent for all dots
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(
            4), // Smooth the corners for the rectangular dot
        border: Border.all(color: Colors.black),
      ),
    );
  }
}
