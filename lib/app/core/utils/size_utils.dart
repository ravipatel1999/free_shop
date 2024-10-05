import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static double getHeightFactor(BuildContext context, double mobileFactor,
      double tabletFactor, double desktopFactor) {
    if (isDesktop(context)) {
      return desktopFactor;
    } else if (isTablet(context)) {
      return tabletFactor;
    }
    return mobileFactor;
  }

  static double getFontSize(BuildContext context, double mobileFontSize) {
    if (isTablet(context)) {
      return mobileFontSize * 1.5;
    }
    return mobileFontSize;
  }

  static double getContainerSize(BuildContext context, double mobileSize) {
    if (isTablet(context)) {
      return mobileSize * 1.5;
    }
    return mobileSize;
  }
}
