import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final Color? borderColor;
  final bool? isEnabled;

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
    this.borderColor,
    this.isEnabled,
  });

  ButtonStyle getButtonStyle(ColorScheme colorScheme) {
    return ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          side: BorderSide(
            color: borderColor ?? colorScheme.primary,
            width: 1.0,
          ),
        ),
      ),
      backgroundColor: WidgetStatePropertyAll(
        backgroundColor ?? colorScheme.primary,
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
    final colorScheme = Theme.of(context).colorScheme;
    return TextButton(
      onPressed: isEnabled == false ? null : onPressed,
      style:
          isEnabled == false
              ? getButtonStyle(colorScheme).copyWith(
                backgroundColor: WidgetStatePropertyAll(colorScheme.outline),
              )
              : getButtonStyle(colorScheme),
      child: Text(text, style: textStyle, textAlign: TextAlign.center),
    );
  }
}
