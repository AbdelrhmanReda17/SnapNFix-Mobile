import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/theming/colors.dart';

class BaseButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final TextStyle textStyle;

  const BaseButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.textStyle,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonWidth,
    this.buttonHeight,
  });

  ButtonStyle getButtonStyle() {
    return ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        ),
      ),
      backgroundColor: WidgetStatePropertyAll(
        backgroundColor ?? ColorsManager.primaryColor,
      ),
      padding: WidgetStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(
          horizontal: horizontalPadding?.w ?? 12.w,
          vertical: verticalPadding?.h ?? 14.h,
        ),
      ),
      fixedSize: WidgetStatePropertyAll(
        Size(buttonWidth?.w ?? double.maxFinite, buttonHeight ?? 50.h),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: getButtonStyle(),
      child: Text(text, style: textStyle, textAlign: TextAlign.center),
    );
  }
}
