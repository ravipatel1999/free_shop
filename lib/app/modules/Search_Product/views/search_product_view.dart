import 'package:eccomerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../components/TextField/constant/app_color.dart';
import '../../../components/TextField/form_text_field.dart';
import '../../../components/testStyle/input_Style.dart';
import '../controllers/search_product_controller.dart';

class SearchProductView extends GetView<Searchcontroller> {
  const SearchProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSearchBarSection(),
              const Divider(height: 20),
              Text('Your Recent Searches', style: AppStyles.fontStyleSemiBold),
              const SizedBox(height: 8),
              Obx(() {
                int itemCount = controller.recentdressNames.length;
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: itemCount * 56.0,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.SHORT_FILTER);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Iconsax.clock,
                                color: AppColors.primaryColor,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  controller.recentdressNames[index],
                                  style: AppStyles.btnStyle14,
                                  softWrap: true,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
              const SizedBox(height: 16),
              Text('Popular Searches', style: AppStyles.fontStyleSemiBold),
              const SizedBox(height: 8),
              Obx(() {
                return Wrap(
                  spacing: 8.0,
                  runSpacing: 6.0,
                  children:
                      List.generate(controller.dressNames.length, (index) {
                    return FilterChip(
                      padding: EdgeInsets.zero,
                      visualDensity:
                          const VisualDensity(vertical: -4, horizontal: -4),
                      label: Text(
                        controller.dressNames[index],
                        style: AppStyles.captionsText,
                      ),
                      backgroundColor: const Color.fromARGB(255, 235, 233, 233),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.transparent),
                      ),
                      onSelected: (bool value) {},
                    );
                  }),
                );
              }),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Hot deal this week',
                        style: AppStyles.fontStyleSemiBold),
                    const Text(
                      'View All',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing:
                            10.0, // Horizontal spacing between items
                        mainAxisSpacing: 10.0,
                        mainAxisExtent:
                            height * 0.37 // Vertical spacing between items
                        ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return
                          // CustomCard(
                          //   imageUrl:
                          //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXPgBbHSc5UoT5tu2RbADX5N8jfy4vjLdQmA&s",
                          //   rating: "3",
                          //   reviewsCount: "7",
                          //   soldCount: "100+ sold", // Example count
                          //   price: "₹113",
                          //   originalPrice: "₹157",
                          //   discountPercentage: "28% off",
                          //   firstOrderDiscount: "₹94 with 1 Special Offer",
                          //   deliveryTime: "Delivery within 1 day",
                          //   title: "Denzolee Men's T-Shirt",
                          //   onFavoritePressed: () {
                          //     // Handle favorite press
                          //   },
                          // );

                          Container(
                        height: 200.0, // Fixed height for each container
                        width: (width - 30) /
                            2, // Width calculated to fit within screen with spacing
                        margin: EdgeInsets.only(
                          top: index < 2
                              ? 10.0
                              : 0.0, // Top margin for the first row
                          left: index % 2 == 0
                              ? 10.0
                              : 0.0, // Left margin for the first column
                          right: index % 2 != 0
                              ? 10.0
                              : 0.0, // Right margin for the second column
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)), // Rounded corners
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.20,
                              width: width,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_yv_Ouav1k6Y53PJX3PtQvUHovBWIALQ3lQ&s")),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            SizedBox(
                              height: height * 0.002,
                            ),
                            Expanded(
                                child: Container(
                              width: width * 0.448,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height * 0.005,
                                  ),
                                  const Text(
                                    "Glidan mens Classic",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: height * 0.005,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Color.fromARGB(60, 59, 59, 59),
                                      ),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      const Text(
                                        '4.5',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      const Text(
                                        '(64)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Color.fromARGB(
                                              255, 103, 103, 103),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 10,
                                        color: Color.fromARGB(60, 59, 59, 59),
                                      ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      const Text(
                                        '200 Sold',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Color.fromARGB(
                                              255, 103, 103, 103),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.007,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        r'$120.00', // Dollar sign displayed correctly
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      const Text(
                                        r'$56.00', // Dollar sign displayed correctly
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(60, 59, 59, 59),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchBarSection() {
    return Row(
      children: [
        IconButton(
          icon: CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.primaryColor,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Iconsax.arrow_left_2, color: AppColors.whiteColor),
              )),
          onPressed: () {
            Get.back();
          },
        ),
        Expanded(
          child: CustomTextFormField(
            autofocus: true,
            height: 50,
            prefix: const Icon(
              Iconsax.search_normal,
              color: AppColors.primaryColor,
              size: 25,
            ),
            borderDecoration: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ),
            hintText: 'Search here...',
            suffix: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Iconsax.microphone,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                SizedBox(width: 15),
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.IMAGE_SEARCH);
                  },
                  icon: Icon(
                    Iconsax.camera,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
