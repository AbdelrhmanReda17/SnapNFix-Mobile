import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveDimensions {
  final double screenWidth;
  final double screenHeight;
  final bool isTablet;
  final bool isLandscape;
  final bool isSmallScreen;

  ResponsiveDimensions({
    required this.screenWidth,
    required this.screenHeight,
    required this.isTablet,
    required this.isLandscape,
    required this.isSmallScreen,
  });
}

class ResponsiveFontSizes {
  final double title;
  final double value;
  final double suffix;
  final double description;
  final double button;

  ResponsiveFontSizes({
    required this.title,
    required this.value,
    required this.suffix,
    required this.description,
    required this.button,
  });
}

ResponsiveFontSizes getResponsiveFontSizes(ResponsiveDimensions dimensions) {
  if (dimensions.isTablet) {
    return ResponsiveFontSizes(
      title: 18.sp,
      value: 32.sp,
      suffix: 16.sp,
      description: 14.sp,
      button: 16.sp,
    );
  } else if (dimensions.screenWidth < 350) {
    return ResponsiveFontSizes(
      title: 13.sp,
      value: 24.sp,
      suffix: 11.sp,
      description: 10.sp,
      button: 11.sp,
    );
  } else if (dimensions.screenWidth < 400) {
    return ResponsiveFontSizes(
      title: 14.sp,
      value: 26.sp,
      suffix: 12.sp,
      description: 11.sp,
      button: 12.sp,
    );
  } else {
    return ResponsiveFontSizes(
      title: 15.sp,
      value: 28.sp,
      suffix: 13.sp,
      description: 12.sp,
      button: 13.sp,
    );
  }
}

ResponsiveDimensions getResponsiveDimensions(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final screenWidth = mediaQuery.size.width;
  final screenHeight = mediaQuery.size.height;
  final isTablet = screenWidth > 600;
  final isLandscape = mediaQuery.orientation == Orientation.landscape;

  return ResponsiveDimensions(
    screenWidth: screenWidth,
    screenHeight: screenHeight,
    isTablet: isTablet,
    isLandscape: isLandscape,
    isSmallScreen: screenWidth < 600 || screenHeight < 600,
  );
}
