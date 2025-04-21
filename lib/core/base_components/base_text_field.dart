import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final int? maxLines;
  final int? maxErrorLines;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

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
    this.maxLines = 1,
    this.maxErrorLines = 2,
    this.validator,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      maxLines: maxLines,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: colorScheme.primary, width: 1.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme.primary.withValues(alpha: 0.4),
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
        hintStyle:
            hintStyle ??
            textStyles.bodyMedium?.copyWith(
              color: colorScheme.primary.withValues(alpha: 0.4),
            ),
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor:
            backgroundColor ??
            colorScheme.surface.withValues(alpha: 0.3),
        filled: true,
        errorMaxLines: maxErrorLines,
      ),
      obscureText: isObscureText,
      style:
          inputTextStyle ??
          textStyles.bodyMedium?.copyWith(color: colorScheme.primary),
      validator: validator,
    );

    // return TextFormField(
    //   controller: controller,
    //   maxLines: maxLines,

    //   decoration: InputDecoration(
    //     isDense: true,
    //     contentPadding:
    //         contentPadding ??
    //         EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
    //     focusedBorder:
    //         focusedBorder ??
    //         OutlineInputBorder(
    //           borderSide: BorderSide(color: colorScheme.primary, width: 1.3),
    //           borderRadius: BorderRadius.circular(8.r),
    //         ),
    //     enabledBorder:
    //         enabledBorder ??
    //         OutlineInputBorder(
    //           borderSide: BorderSide(
    //             color: colorScheme.primary.withValues(alpha: 0.4),
    //             width: 1.3,
    //           ),
    //           borderRadius: BorderRadius.circular(8.r),
    //         ),
    //     hintStyle:
    //         hintStyle ??
    //         textStyles.bodyMedium?.copyWith(
    //           color: colorScheme.primary.withValues(alpha: 0.4),
    //         ),
    //     hintText: hintText,
    //     suffixIcon: suffixIcon,
    //     fillColor:
    //         backgroundColor ?? colorScheme.surface.withValues(alpha: 0.3),
    //     filled: true,
    //   ),
    //   obscureText: isObscureText,
    //   style:
    //       inputTextStyle ??
    //       textStyles.bodyMedium?.copyWith(color: colorScheme.primary),
    // );
  }
}
