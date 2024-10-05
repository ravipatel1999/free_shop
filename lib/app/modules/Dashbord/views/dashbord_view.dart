import 'package:eccomerce_app/app/components/TextField/constant/app_color.dart';
import 'package:eccomerce_app/app/custom/button.dart';
import 'package:eccomerce_app/app/custom/imagecustom.dart';
import 'package:eccomerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../components/testStyle/input_Style.dart';
import '../../../core/utils/size_utils.dart';
import '../../../custom/appBar.dart';
import '../../../custom/dashbordCard.dart';
import '../controllers/dashbord_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashbordView extends GetView<DashbordController> {
  const DashbordView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        title: const CustomHeader(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                buildSearchBarSection(),
                const SizedBox(height: 15),
                buildCarouselSection(
                    height: height, width: width, context: context),
                const SizedBox(height: 20),
                const Text(
                  'Popular Brand',
                  style: AppStyles.headerStyle,
                ),
                const SizedBox(height: 10),
                Container(
                  height: height * 0.06,
                  width: width,
                  color: Colors.transparent,
                  child: Container(
                    height: height * 0.06,
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
                                  print('ravi$index');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      controller.selectedIndex.value == index
                                          ? Colors.black
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
                                        color: controller.selectedIndex.value ==
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
                const Row(
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
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomCard(
                        imageUrl:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXPgBbHSc5UoT5tu2RbADX5N8jfy4vjLdQmA&s",
                        rating: "3",
                        reviewsCount: "7",
                        soldCount: "100+ sold", // Example count
                        price: "₹113",
                        originalPrice: "₹157",
                        discountPercentage: "28% off",
                        firstOrderDiscount: "₹94 with 1 Special Offer",
                        deliveryTime: "Delivery within 1 day",
                        title: "Denzolee Men's T-Shirt",
                        onFavoritePressed: () {
                          // Handle favorite press
                        },
                      ),
                    );
                  })),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Arrival',
                      style: AppStyles.fontStyleSemiBold,
                    ),
                    Text(
                      'View all',
                      style: AppStyles.btnStyle2,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.PRODUCT_DETAILS);
                        },
                        child: CustomCard(
                          imageUrl:
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXPgBbHSc5UoT5tu2RbADX5N8jfy4vjLdQmA&s",
                          rating: "3",
                          reviewsCount: "7",
                          soldCount: "100+ sold", // Example count
                          price: "₹113",
                          originalPrice: "₹157",
                          discountPercentage: "28% off",
                          firstOrderDiscount: "₹94 with 1 Special Offer",
                          deliveryTime: "Delivery within 1 day",
                          title: "Denzolee Men's T-Shirt",
                          onFavoritePressed: () {
                            // Handle favorite press
                          },
                        ),
                      ),
                    );
                  })),
                ),
                const Padding(padding: EdgeInsets.all(15))
              ],
            ),
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

  Widget buildCarouselSection(
      {required double height,
      required double width,
      required BuildContext context}) {
    return Obx(() {
      final double carouselHeight =
          height * ResponsiveHelper.getHeightFactor(context, 0.2, 0.4, 0.4);

      return CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          height: carouselHeight,
          viewportFraction: 0.85,
          enlargeCenterPage: true,
        ),
        items: controller.items.map((item) {
          return Container(
            height: carouselHeight,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 195, 193, 212),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 38,
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
                      width: width * 0.28,
                      height: carouselHeight * 0.18,
                      child: CustomButton(
                        text: 'Get Now',
                        textStyle: AppStyles.appBarStyle,
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: carouselHeight * 0.975,
                  width: width * 0.32,
                  child: CustomImageView(
                    fit: BoxFit.contain,
                    imagePath: item.imageUrl,
                  ),
                )
              ],
            ),
          );
        }).toList(),
      );
    });
  }
}
