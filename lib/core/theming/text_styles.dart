import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/theming/colors.dart';

enum TextColor {
  primaryColor,
  secondaryColor,
  tertiaryColor,
  quaternaryColor,
  quinaryColor,
  grayColor,
}

class TextColorsManager {
  static Color getColor(TextColor color) {
    switch (color) {
      case TextColor.primaryColor:
        return ColorsManager.primaryColor;
      case TextColor.secondaryColor:
        return ColorsManager.secondaryColor;
      case TextColor.tertiaryColor:
        return ColorsManager.tertiaryColor;
      case TextColor.quaternaryColor:
        return ColorsManager.quaternaryColor;
      case TextColor.quinaryColor:
        return ColorsManager.quinaryColor;
      case TextColor.grayColor:
        return ColorsManager.grayColor;
    }
  }
}

class TextStyles {
  static TextStyle font24Bold(TextColor color) {
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      color: TextColorsManager.getColor(color),
    );
  }

  static TextStyle font16Normal(TextColor color) {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: TextColorsManager.getColor(color),
    );
  }

  static TextStyle font12Normal(TextColor color) {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: TextColorsManager.getColor(color),
    );
  }
}
