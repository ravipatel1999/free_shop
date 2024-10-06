import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../components/TextField/constant/app_color.dart';
import '../../../custom/imagecustom.dart';
import '../controllers/rating_review_controller.dart';

class RatingReviewView extends GetView<RatingReviewController> {
  const RatingReviewView({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          title: const Text('Rating & Reviews'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  _reviewsSection(),
                  const SizedBox(height: 30),
                  _cateSection(height, width),
                  const SizedBox(height: 15),
                  _cateRattingSection(height, width),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Iconsax.arrow_3),
                      SizedBox(width: 8),
                      Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: AppColors.whiteColor,
                            value: controller.selectedValue.value == 'Sort'
                                ? null
                                : controller.selectedValue.value,
                            hint: Text('Sort'),
                            icon: Icon(Icons.arrow_drop_down),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                controller.setSelectedValue(newValue);
                              }
                            },
                            items: ['Most Recent', 'Most Relevant']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                            onTap: () {},
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
              ),
            ),
          ),
        ));
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Colour Family: Black'),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Iconsax.like_15,
                          color: AppColors.hintColor,
                        ),
                        onPressed: controller.incrementLike,
                      ),
                      Obx(() => Text('${controller.likeCount}')),
                      IconButton(
                        icon: Icon(Iconsax.dislike),
                        onPressed: controller.incrementDislike,
                      ),
                      Obx(() => Text('${controller.dislikeCount}')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cateSection(height, width) {
    return Container(
      height: height * 0.05,
      width: width,
      color: Colors.transparent,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 15 : 5,
              right: 5,
            ),
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  controller.selectCategory(index);
                  print('Selected category: $index');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.selectedIndex.value == index
                      ? Colors.black
                      : const Color.fromARGB(255, 246, 246, 246),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    if (category['icon'] != null)
                      Icon(
                        category['icon'],
                        color: controller.selectedIndex.value == index
                            ? Colors.white
                            : Colors.black,
                        size: 16,
                      ),
                    if (category['icon'] != null) SizedBox(width: 5),
                    Text(
                      '${category['name']} (${category['count']})',
                      style: TextStyle(
                        color: controller.selectedIndex.value == index
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
    );
  }

  Widget _cateRattingSection(height, width) {
    return Container(
      height: height * 0.05,
      width: width,
      color: Colors.transparent,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.ratingcategories.length,
        itemBuilder: (context, index) {
          final category = controller.ratingcategories[index];
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 15 : 5,
              right: 5,
            ),
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  controller.selectCategory(index);
                  print('Selected category: $index');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.selectedIndex.value == index
                      ? Colors.black
                      : const Color.fromARGB(255, 246, 246, 246),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star, // Show the star icon here
                      color: controller.selectedIndex.value == index
                          ? Colors.white
                          : Colors.black,
                      size: 16,
                    ),
                    SizedBox(width: 5), // Space between icon and text
                    Text(
                      '${category['count']} (${category['total']})', // Assuming 'total' holds the second number
                      style: TextStyle(
                        color: controller.selectedIndex.value == index
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
    );
  }

  Widget _reviewsSection() {
    final List<double> reviewRatings = [0.7, 0.5, 0.3, 0.2, 0.1];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
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
      ],
    );
  }
}
