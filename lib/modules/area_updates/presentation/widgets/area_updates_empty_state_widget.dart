import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_button.dart';

class AreaUpdatesEmptyStateWidget extends StatelessWidget {
  final ColorScheme colorScheme;
  final VoidCallback? onBrowseAreas;

  const AreaUpdatesEmptyStateWidget({
    super.key,
    required this.colorScheme,
    this.onBrowseAreas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primaryContainer.withOpacity(0.3),
            colorScheme.secondaryContainer.withOpacity(0.2),
          ],
        ),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.location_city_outlined,
            size: 48.sp,
            color: colorScheme.primary,
          ),
          SizedBox(height: 12.h),
          Text(
            'No Areas Subscribed',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Subscribe to areas to get real-time updates about issues in your neighborhood',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 16.h),
          BaseButton(
            text: 'Browse Areas',
            onPressed: onBrowseAreas,
            textStyle: TextStyle(
              fontSize: 14.sp,
              color: colorScheme.onPrimary,
            ),
            backgroundColor: colorScheme.primary,
            borderRadius: 12.r,
          ),
        ],
      ),
    );
  }
}
