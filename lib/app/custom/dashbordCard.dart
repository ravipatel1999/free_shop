import 'package:eccomerce_app/app/components/TextField/constant/app_color.dart';
import 'package:eccomerce_app/app/custom/imagecustom.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../components/testStyle/input_Style.dart';

class CustomCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String rating;
  final String reviewsCount;
  final String soldCount;
  final String price;
  final String originalPrice;
  final String discountPercentage;
  final String firstOrderDiscount;
  final String deliveryTime;
  final Color backgroundColor;
  final Color titleColor;
  final Color priceColor;
  final Color discountPriceColor;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  const CustomCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.reviewsCount,
    required this.soldCount,
    required this.price,
    required this.originalPrice,
    required this.discountPercentage,
    required this.firstOrderDiscount,
    required this.deliveryTime,
    this.backgroundColor = Colors.transparent,
    this.titleColor = AppColors.primaryColor,
    this.priceColor = AppColors.primaryColor,
    this.discountPriceColor = const Color.fromARGB(60, 59, 59, 59),
    this.isFavorite = false,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFEBEBEB),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomImageView(
                      // height: 200,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      imagePath: imageUrl,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(Iconsax.heart),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            SizedBox(height: height * 0.005),
            Row(
              children: [
                Text(
                  price,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: priceColor,
                  ),
                ),
                SizedBox(width: width * 0.02),
                Text(
                  originalPrice,
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: discountPriceColor,
                  ),
                ),
                SizedBox(width: width * 0.01),
                Text(discountPercentage, style: AppStyles.captionsText),
              ],
            ),
            Text(
              deliveryTime,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.blue,
              ),
            ),
            Text(
              firstOrderDiscount,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.green,
              ),
            ),
            Text("Free Delivery", style: AppStyles.captionsText),
            SizedBox(height: height * 0.005),
            Row(
              children: [
                SizedBox(width: width * 0.005),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.greenColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          rating,
                          style: AppStyles.appBarStyle,
                        ),
                        SizedBox(width: width * 0.005),
                        Icon(
                          Icons.star,
                          size: 15,
                          color: AppColors.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                Text(
                  '($reviewsCount)',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: const Color.fromARGB(255, 103, 103, 103),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
