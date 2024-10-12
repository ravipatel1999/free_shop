import 'package:eccomerce_app/app/components/TextField/constant/app_color.dart';
import 'package:eccomerce_app/app/components/testStyle/input_Style.dart';
import 'package:eccomerce_app/app/custom/imagecustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../routes/app_pages.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.imagePaths.length,
                  (index) => Obx(
                      () => _buildDot(index == controller.currentPage.value)),
                ),
              ),
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
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Iconsax.heart,
                                size: 15,
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    const Row(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Available Vouchers',
                          style: AppStyles.fontStyleSemiBold,
                        ),
                        Text(
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
                                  ? const Center(
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
              const Padding(padding: EdgeInsets.only(bottom: 100))
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(color: AppColors.whiteColor),
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
                      child: const Icon(Iconsax.message)),
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
                    child: const Center(
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
                  onTap: () {
                    Get.bottomSheet(
                      _buildBottomSheet(controller),
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.carbonColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
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
        onPageChanged: (int index) {
          controller.currentPage.value = index;
        },
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
                decoration: const BoxDecoration(color: AppColors.whiteColor),
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
                          icon: const Icon(
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
                        icon: const Icon(Iconsax.arrow_square_left,
                            size: 30, color: AppColors.primaryColor),
                        onPressed: () {
                          setState(() {
                            if (currentIndex > 0) {
                              currentIndex--;
                              pageController.animateToPage(
                                currentIndex,
                                duration: const Duration(milliseconds: 300),
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
                        icon: const Icon(Iconsax.arrow_right,
                            size: 30, color: AppColors.primaryColor),
                        onPressed: () {
                          setState(() {
                            if (currentIndex <
                                controller.imagePaths.length - 1) {
                              currentIndex++;
                              pageController.animateToPage(
                                currentIndex,
                                duration: const Duration(milliseconds: 300),
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
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Iconsax.discount_shape,
                    size: 25,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(text, style: AppStyles.inputFloatingStyle),
                ],
              ),
              const SizedBox(height: 4),
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
          const Text('  :  '),
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
        // Row(
        //   children: [
        //     const Text(
        //       '4.8',
        //       style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        //     ),
        //     const SizedBox(width: 8.0),
        //     Expanded(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: List.generate(5, (index) {
        //           return Row(
        //             children: [
        //               const Icon(Icons.star,
        //                   color: AppColors.hintColor, size: 16),
        //               const SizedBox(width: 4.0),
        //               Text('${5 - index}'),
        //               const SizedBox(width: 4.0),
        //               Expanded(
        //                 child: LinearProgressIndicator(
        //                   value: reviewRatings[index],
        //                   minHeight: 4.0,
        //                   backgroundColor: Colors.grey[300],
        //                 ),
        //               ),
        //               const SizedBox(width: 8.0),
        //               Text('${(reviewRatings[index] * 100).toInt()}%'),
        //             ],
        //           );
        //         }),
        //       ),
        //     ),
        //   ],
        // ),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '4.8',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  RatingBar.builder(
                    initialRating: 4.8,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: AppColors.hintColor,
                    ),
                    onRatingUpdate: (rating) {},
                    ignoreGestures: true, // To make it read-only
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: AppColors.hintColor, size: 16),
                      const SizedBox(width: 4),
                      Text('4.5 (64) * 200 Sold'),
                    ],
                  ),
                ],
              ),
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
        Obx(() => ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.reviews.length,
              itemBuilder: (context, index) {
                final review = controller.reviews[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.RATING_REVIEW);
                  },
                  child: _reviewCard(
                    review['userName'] as String,
                    review['userImage'] as String,
                    review['rating'] as int,
                    review['reviewText'] as String,
                    List<String>.from(review['reviewImages'] as List),
                  ),
                );
              },
            )),
      ],
    );
  }

  Widget _reviewCard(String userName, String userImage, int rating,
      String reviewText, List<String> reviewImages) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 218, 217, 217)),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(-4),
              leading: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 232, 232, 232),
                child: CustomImageView(
                  imagePath: 'assets/Men_Shirts.png',
                ),
              ),
              title: Text(userName,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('2 days ago'),
              trailing: PopupMenuButton<String>(
                color: AppColors.whiteColor,
                onSelected: (value) {
                  if (value == 'report') {
                    print('Report clicked');
                  } else if (value == 'about') {
                    print('About clicked');
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'report',
                    child: Text('Report'),
                  ),
                  PopupMenuItem(
                    value: 'about',
                    child: Text('About'),
                  ),
                ],
                icon: Icon(Icons.more_vert),
                offset: Offset(0, 40),
              ),
            ),
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
                const Text('  3 stars')
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
                return Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 240, 240),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: CustomImageView(
                    imagePath: reviewImages[index],
                    fit: BoxFit.contain,
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
      width: isActive ? 16 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : const Color.fromARGB(255, 90, 89, 89),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black),
      ),
    );
  }

  Widget _buildBottomSheet(ProductDetailsController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 4,
              width: 40,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 15),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Choose Product Variant',
              style: AppStyles.headerStyle,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(
            color: Colors.grey,
            thickness: 0.2,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFF6F5F5),
                        borderRadius: BorderRadius.circular(9)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomImageView(
                        imagePath: 'assets/sharess.png',
                        height: 100,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Gildan mens Classic',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const Text('Stock: 160'),
                      const Row(
                        children: [
                          Text(
                            '\$120.00',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '\$140.00',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(() {
                        return Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFF6F5F5),
                              border:
                                  Border.all(width: 0.2, color: Colors.grey),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 2),
                            child: Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      controller.decrement();
                                    },
                                    child: const Icon(Icons.remove)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                  ),
                                  child: Text('${controller.quantity}'),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      controller.increment();
                                    },
                                    child: const Icon(Icons.add)),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Size'),
          const SizedBox(height: 8),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['XXS', 'XS', 'S', 'M', 'L', 'XL']
                  .map((size) => GestureDetector(
                        onTap: () => controller.selectedSize.value = size,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: controller.selectedSize.value == size
                                ? Colors.black
                                : Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              color: controller.selectedSize.value == size
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Color'),
          const SizedBox(height: 8),
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
                bool isSelected = controller.selectedColor.value == color;
                return GestureDetector(
                  onTap: () => controller.selectedColor.value = color,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 32,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: color,
                    ),
                    child: isSelected
                        ? const Center(
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
          const SizedBox(height: 16),
          Container(
            decoration: const BoxDecoration(color: AppColors.whiteColor),
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 4,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.carbonColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
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
                        child: const Center(
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
        ],
      ),
    );
  }

  Widget _buildSizeOption(String size) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(size),
    );
  }

  Widget _buildColorOption(Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
