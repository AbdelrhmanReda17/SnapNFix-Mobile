import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseTextField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final String? labelText;
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
    this.labelText,
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: textStyles.bodyMedium?.copyWith(
              color: colorScheme.primary.withValues(alpha: 0.5),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 2.h),
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: maxLines,
          decoration: InputDecoration(
            isDense: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding:
                contentPadding ??
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
            focusedBorder:
                focusedBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
            enabledBorder:
                enabledBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorScheme.primary.withValues(alpha: 0.2),
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorScheme.error, width: 1.3),
              borderRadius: BorderRadius.circular(12.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorScheme.error, width: 1.3),
              borderRadius: BorderRadius.circular(12.r),
            ),
            hintStyle:
                hintStyle ??
                textStyles.bodyMedium?.copyWith(
                  color: colorScheme.primary.withValues(alpha: 0.5),
                  fontSize: 16.sp,
                ),
            hintText: hintText,
            suffixIcon: suffixIcon,
            fillColor: backgroundColor ?? Colors.white,
            filled: true,
            errorMaxLines: maxErrorLines,
          ),
          obscureText: isObscureText,
          style:
              inputTextStyle ??
              textStyles.bodyMedium?.copyWith(
                color: colorScheme.primary,
                fontSize: 16.sp,
              ),
          validator: validator,
        ),
      ],
    );
  }
}
