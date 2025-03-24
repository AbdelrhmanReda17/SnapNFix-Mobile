import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/theming/colors.dart';
import 'package:snapnfix/core/theming/text_styles.dart';

class BaseTextField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final VoidCallback? toggleObscureText;
  final bool isObscureText;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final Color? backgroundColor;

  const BaseTextField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.toggleObscureText,
    this.hintStyle,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.suffixIcon,
    this.backgroundColor,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.primaryColor,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.lightGrayColor,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
        hintStyle: hintStyle ?? TextStyles.font14Normal(TextColor.primaryColor),
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: backgroundColor ?? ColorsManager.whiteColor,
        filled: true,
      ),
      obscureText: isObscureText,
      style: TextStyles.font14Normal(TextColor.primaryColor),
    );
  }
}
