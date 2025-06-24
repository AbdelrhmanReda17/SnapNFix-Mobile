import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_button.dart';

class AreaUpdatesErrorWidget extends StatelessWidget {
  final String message;
  final ColorScheme colorScheme;
  final VoidCallback? onRetry;

  const AreaUpdatesErrorWidget({
    super.key,
    required this.message,
    required this.colorScheme,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: colorScheme.errorContainer.withOpacity(0.3),
        border: Border.all(color: colorScheme.error.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: colorScheme.error),
          SizedBox(height: 12.h),
          Text(
            'Unable to Load Areas',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onErrorContainer,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: colorScheme.onErrorContainer.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 16.h),
          BaseButton(
            text: 'Retry',
            onPressed: onRetry,
            backgroundColor: colorScheme.error,
            textStyle: TextStyle(
              color: colorScheme.onErrorContainer,
              fontSize: 14.sp,
            ),
            borderRadius: 12.r,
          ),
        ],
      ),
    );
  }
}
