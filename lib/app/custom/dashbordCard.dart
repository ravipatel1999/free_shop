import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String rating;
  final String reviewsCount;
  final String soldCount;
  final String price;
  final String originalPrice;
  final Color backgroundColor;
  final Color titleColor;
  final Color priceColor;
  final Color discountPriceColor;

  const CustomCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.reviewsCount,
    required this.soldCount,
    required this.price,
    required this.originalPrice,
    this.backgroundColor = Colors.transparent,
    this.titleColor = Colors.black,
    this.priceColor = Colors.black,
    this.discountPriceColor = const Color.fromARGB(60, 59, 59, 59),
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
          color: backgroundColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
              height: height * 0.25,
              width: width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(imageUrl)),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10))),
          SizedBox(height: height * 0.002),
          Expanded(
              child: Container(
            width: width * 0.448,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.005),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: titleColor),
                ),
                SizedBox(height: height * 0.005),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 15,
                      color: const Color.fromARGB(60, 59, 59, 59),
                    ),
                    SizedBox(width: width * 0.005),
                    Text(
                      rating,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: width * 0.005),
                    Text(
                      '($reviewsCount)',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 103, 103, 103),
                      ),
                    ),
                    SizedBox(width: width * 0.01),
                    Icon(
                      Icons.star,
                      size: 10,
                      color: const Color.fromARGB(60, 59, 59, 59),
                    ),
                    SizedBox(width: width * 0.01),
                    Text(
                      soldCount,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 103, 103, 103),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.007),
                Row(
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: priceColor),
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      originalPrice,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: discountPriceColor,
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
  }
}
