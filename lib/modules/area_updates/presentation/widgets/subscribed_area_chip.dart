import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscribedAreaChip extends StatelessWidget {
  final String areaName;
  final ColorScheme colorScheme;
  final VoidCallback? onUnsubscribe;

  const SubscribedAreaChip({
    super.key,
    required this.areaName,
    required this.colorScheme,
    this.onUnsubscribe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, size: 16.sp, color: colorScheme.primary),
          SizedBox(width: 6.w),
          Text(
            areaName,
            style: TextStyle(
              fontSize: 14.sp,
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (onUnsubscribe != null) ...[
            SizedBox(width: 6.w),
            GestureDetector(
              onTap: onUnsubscribe,
              child: Icon(
                Icons.close,
                size: 16.sp,
                color: colorScheme.onPrimaryContainer.withOpacity(0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
