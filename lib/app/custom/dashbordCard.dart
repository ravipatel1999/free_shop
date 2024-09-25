import 'package:eccomerce_app/app/components/TextField/constant/app_color.dart';
import 'package:eccomerce_app/app/components/testStyle/textStyle.dart';
import 'package:flutter/material.dart';

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
    this.titleColor = Colors.black,
    this.priceColor = Colors.black,
    this.discountPriceColor = const Color.fromARGB(60, 59, 59, 59),
    this.isFavorite = false,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(left: width * 0.028, right: width * 0.029),
      height: height,
      width: width * 0.42,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: height * 0.25,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(imageUrl),
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: CircleAvatar(
                  backgroundColor: AppColors.whiteColor,
                  child: IconButton(
                    icon: Icon(
                      size: 25,
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: onFavoritePressed,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.002),
          Expanded(
            child: Container(
              width: width * 0.448,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.005),
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
                      Text(discountPercentage, style: CustomTextStyles.caption),
                    ],
                  ),
                  Text(
                    deliveryTime,
                    style: TextStyle(
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
                  Text("Free Delivery", style: CustomTextStyles.caption),
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
                                style: CustomTextStyles.appBarSubText14,
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
          ),
        ],
      ),
    );
  }
}
