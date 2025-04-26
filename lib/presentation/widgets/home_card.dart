import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String mainValue;
  final String valueSuffix; // New parameter for the suffix text
  final String description;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final String? imageAsset;
  final double? imageWidth;
  final double? imageHeight;
  final Offset? imageOffset;
  final ColorScheme colorScheme;

  const CustomCard({
    super.key,
    required this.title,
    required this.mainValue,
    this.valueSuffix = '',
    required this.description,
    required this.buttonText,
    this.onButtonPressed,
    this.imageAsset,
    this.imageWidth,
    this.imageHeight,
    this.imageOffset,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Container(
        width: 280.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8.r,
            colors: [const Color(0xFF23576D), colorScheme.primary],
            stops: const [0.0, 1.0],
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      mainValue,
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w900,
                        color: colorScheme.onPrimary,
                        height: 1.4.h,
                      ),
                    ),
                    if (valueSuffix.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h, left: 4.w),
                        child: Text(
                          valueSuffix,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimary.withOpacity(0.8),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: colorScheme.onPrimary.withOpacity(0.7),
                  ),
                ),
                const Spacer(),
                if (onButtonPressed != null)
                  Center(
                    child: TextButton(
                      onPressed: onButtonPressed,
                      style: TextButton.styleFrom(
                        foregroundColor: colorScheme.onPrimary.withOpacity(0.9),
                        backgroundColor: colorScheme.onPrimary.withOpacity(0.2),
                        minimumSize: Size(double.minPositive, 36.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(buttonText, style: TextStyle(fontSize: 12.sp)),
                    ),
                  ),
              ],
            ),
            if (imageAsset != null)
              Positioned(
                right: 0,
                top: 0,
                child: Transform.translate(
                  offset: imageOffset ?? Offset.zero,
                  child: Image.asset(
                    imageAsset!,
                    width: imageWidth ?? 70.w,
                    height: imageHeight ?? 70.w,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}