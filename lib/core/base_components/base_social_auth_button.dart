import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseSocialAuthButton extends StatelessWidget {
  final String assetPath;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const BaseSocialAuthButton({
    super.key,
    required this.assetPath,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
        minimumSize: Size(50.w, 50.w),
        maximumSize: Size(50.w, 50.w),
      ),
      child: Container(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Center(child: Image.asset(assetPath, width: 24.w, height: 24.w)),
      ),
    );
  }
}
