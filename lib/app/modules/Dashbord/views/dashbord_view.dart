import 'package:eccomerce_app/app/components/TextField/constant/app_color.dart';
import 'package:eccomerce_app/app/custom/button.dart';
import 'package:eccomerce_app/app/custom/imagecustom.dart';
import 'package:eccomerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../components/testStyle/input_Style.dart';
import '../../../core/utils/size_utils.dart';
import '../controllers/dashbord_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashbordView extends GetView<DashbordController> {
  const DashbordView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final double itemHeight = MediaQuery.of(context).size.height * 0.45;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: buildSearchBarSection(),
              ),
              const SizedBox(height: 15),
              buildCarouselSection(
                  height: height, width: width, context: context),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Popular Brand',
                      style: AppStyles.headerStyle,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: height * 0.05,
                      width: width,
                      color: Colors.transparent,
                      child: Container(
                        height: height * 0.05,
                        width: width,
                        color: Colors.transparent,
                        child: Obx(
                          () => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.categories.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: index == 0 ? 15 : 5,
                                  right: 5,
                                ),
                                child: Obx(
                                  () => ElevatedButton(
                                    onPressed: () {
                                      controller.selectCategory(index);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          controller.selectedIndex.value ==
                                                  index
                                              ? AppColors.carbonColor
                                              : const Color.fromARGB(
                                                  255, 246, 246, 246),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          controller.categories[index],
                                          style: TextStyle(
                                            color: controller
                                                        .selectedIndex.value ==
                                                    index
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Most Popular',
                            style: AppStyles.fontStyleSemiBold,
                          ),
                          Text(
                            'View all',
                            style: AppStyles.btnStyle2,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.PRODUCT_DETAILS);
                      },
                      child: SizedBox(
                        height: itemHeight,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: const Color(0xFFF6F5F5),
                                              ),
                                              height: itemHeight * 0.55,
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: CustomImageView(
                                                  imagePath:
                                                      'assets/Men_Shirts.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 1.0,
                                              right: 1.0,
                                              child: IconButton(
                                                icon: const CircleAvatar(
                                                  backgroundColor:
                                                      AppColors.whiteColor,
                                                  child: Icon(
                                                    Iconsax.heart,
                                                  ),
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Denzolee Men's T-Shirt",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.buttonColor,
                                          ),
                                        ),
                                        SizedBox(height: height * 0.002),
                                        Row(
                                          children: [
                                            Text(
                                              "₹157",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.buttonColor,
                                              ),
                                            ),
                                            SizedBox(width: width * 0.02),
                                            Text(
                                              '₹113',
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: AppColors.hintColor,
                                              ),
                                            ),
                                            SizedBox(width: width * 0.01),
                                            Text('28% off',
                                                style: AppStyles.captionsText),
                                          ],
                                        ),
                                        Text(
                                          "Delivery within 1 day",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        Text(
                                          "₹94 with 1 Special Offer",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.green,
                                          ),
                                        ),
                                        Text("Free Delivery",
                                            style: AppStyles.captionsText),
                                        SizedBox(height: height * 0.005),
                                        Row(
                                          children: [
                                            SizedBox(width: width * 0.005),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.greenColor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6.0),
                                                child: Row(
                                                  children: [
                                                    Text('3',
                                                        style: AppStyles
                                                            .appBarStyle),
                                                    SizedBox(
                                                        width: width * 0.005),
                                                    Icon(
                                                      Icons.star,
                                                      size: 15,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: width * 0.01),
                                            Text(
                                              '(7)',
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12,
                                                color: const Color.fromARGB(
                                                    255, 103, 103, 103),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    // width: itemWidth,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: const Color(0xFFF6F5F5),
                                              ),
                                              height: itemHeight * 0.55,
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: CustomImageView(
                                                  imagePath:
                                                      'assets/Men_Shirts.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 1.0,
                                              right: 1.0,
                                              child: IconButton(
                                                icon: const CircleAvatar(
                                                  backgroundColor:
                                                      AppColors.whiteColor,
                                                  child: Icon(
                                                    Iconsax.heart,
                                                  ),
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Denzolee Men's T-Shirt",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.buttonColor,
                                          ),
                                        ),
                                        SizedBox(height: height * 0.002),
                                        Row(
                                          children: [
                                            Text(
                                              "₹157",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.buttonColor,
                                              ),
                                            ),
                                            SizedBox(width: width * 0.02),
                                            Text(
                                              '₹113',
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: AppColors.hintColor,
                                              ),
                                            ),
                                            SizedBox(width: width * 0.01),
                                            Text('28% off',
                                                style: AppStyles.captionsText),
                                          ],
                                        ),
                                        Text(
                                          "Delivery within 1 day",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        Text(
                                          "₹94 with 1 Special Offer",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.green,
                                          ),
                                        ),
                                        Text("Free Delivery",
                                            style: AppStyles.captionsText),
                                        SizedBox(height: height * 0.005),
                                        Row(
                                          children: [
                                            SizedBox(width: width * 0.005),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.greenColor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6.0),
                                                child: Row(
                                                  children: [
                                                    Text('3',
                                                        style: AppStyles
                                                            .appBarStyle),
                                                    SizedBox(
                                                        width: width * 0.005),
                                                    Icon(
                                                      Icons.star,
                                                      size: 15,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: width * 0.01),
                                            Text(
                                              '(7)',
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12,
                                                color: const Color.fromARGB(
                                                    255, 103, 103, 103),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
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

  Widget buildSearchBarSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SEARCH_PRODUCT);
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.blackColor,
                    width: 1,
                  ),
                  color: AppColors.whiteColor, // Background color
                ),
                child: Row(
                  children: [
                    const Icon(
                      Iconsax.search_normal,
                      color: AppColors.blackColor,
                      size: 25,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Search here...',
                        style: AppStyles.inputStyle.copyWith(
                          color: AppColors.hintColor,
                        ),
                      ),
                    ),
                    const Icon(
                      Iconsax.microphone,
                      color: AppColors.blackColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.FILTER_PRODUCT);
            },
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Icon(
                  Iconsax.setting_5,
                  color: AppColors.blackColor,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
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
        color:
            isActive ? Colors.black : const Color.fromARGB(255, 158, 156, 156),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black),
      ),
    );
  }

  Widget buildCarouselSection(
      {required double height,
      required double width,
      required BuildContext context}) {
    return Obx(() {
      final double carouselHeight =
          height * ResponsiveHelper.getHeightFactor(context, 0.23, 0.4, 0.4);

      return Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: carouselHeight,
              viewportFraction: 1,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                controller.currentPage.value = index;
              },
            ),
            items: controller.items.map((item) {
              return Container(
                height: carouselHeight,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 195, 193, 212),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item.subtitle,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        SizedBox(
                          width: width * 0.30,
                          height: carouselHeight * 0.18,
                          child: CustomButton(
                            text: 'Get Now',
                            textStyle: AppStyles.appBarStyle,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: carouselHeight * 0.975,
                      width: width * 0.32,
                      child: CustomImageView(
                        fit: BoxFit.contain,
                        imagePath: item.imageUrl,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(controller.items.length, (index) {
                return _buildDot(index == controller.currentPage.value);
              }),
            ),
          ),
        ],
      );
    });
  }
}
