import 'package:flutter/material.dart';

import '../TextField/constant/app_color.dart';

class CustomTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 42.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );
  static const TextStyle headlinered3 = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    color: AppColors.buttonColor,
  );
  static const TextStyle headline4 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 60, 77, 95),
  );
  static const TextStyle bodybold = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle bodyboldred = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: AppColors.buttonColor,
  );
  static const TextStyle bodybolblack18 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );
  static const TextStyle bodyboldred18 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: AppColors.buttonColor,
  );
  static const TextStyle bodyboldred14 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: AppColors.buttonColor,
  );
  static const TextStyle bodyTextBold = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle bodyTextNormal = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static const TextStyle bodyBoldCard = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: Colors.black45,
  );
  static const TextStyle bodyText2black = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static const TextStyle captionBigBold = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.black38,
  );
  static const TextStyle captionBold = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: Colors.black38,
  );
  static const TextStyle captionBoldBlack = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(147, 0, 0, 0),
  );
  static const TextStyle locationText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Color(0xFF000000),
  );
  static const TextStyle appBarMainText = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    color: AppColors.buttonColor,
  );
  static const TextStyle appBarText = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );
  static const TextStyle appBarSubText = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
  );
  static const TextStyle appBarSubText14 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );
  static const TextStyle smallcaption = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(147, 0, 0, 0),
  );
}
  // ListView.separated(
              //   physics: const NeverScrollableScrollPhysics(),
              //   separatorBuilder: (context, index) => const SizedBox(
              //     height: 10,
              //   ),
              //   itemCount: 2,
              //   shrinkWrap: true,
              //   itemBuilder: (context, index) => Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //       color: AppColors.backgroundColor,
              //     ),
              //     child: Padding(
              //       padding:
              //           const EdgeInsets.only(left: 4.0, right: 8.0, bottom: 8),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           SizedBox(
              //             width: getWidth(context: context, value: 100),
              //             child: Image.asset(
              //               'assets/baseimages/Untitled design (79) (2).png',
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //           const SizedBox(width: 10),
              //           Expanded(
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 const Text(
              //                   'Awesome Pizza American Cheesy',
              //                   style: CustomTextStyles.bodyBoldCard,
              //                   maxLines: 2,
              //                   overflow: TextOverflow.ellipsis,
              //                 ),
              //                 const Text(
              //                   'Medium | New Hand Tested',
              //                   maxLines: 2,
              //                   overflow: TextOverflow.ellipsis,
              //                   style: CustomTextStyles.bodyText1,
              //                 ),
              //                 const SizedBox(
              //                   height: 10,
              //                 ),
              //                 Row(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     QuantityButton(),
              //                     const Text(
              //                       '₹4999/-',
              //                       style: CustomTextStyles.headline3,
              //                     ),
              //                   ],
              //                 )
              //               ],
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),