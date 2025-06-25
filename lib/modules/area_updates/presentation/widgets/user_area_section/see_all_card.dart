import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SeeAllCard extends StatelessWidget {
  final ColorScheme colorScheme;
  final VoidCallback? onTap;

  const SeeAllCard({super.key, required this.colorScheme, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 140.w,
      height: 120.h,
      margin: EdgeInsets.only(right: 16.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: colorScheme.surfaceContainer,
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: .1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.3),
                  spreadRadius: isDarkMode ? 1 : 0.5,
                  blurRadius: isDarkMode ? 3 : 2,
                  offset: Offset(0, isDarkMode ? 2 : 1),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with background
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.grid_view_rounded,
                    size: 16.sp,
                    color: colorScheme.primary,
                  ),
                ),

                SizedBox(height: 6.h),

                // Text
                Text(
                  AppLocalizations.of(context)!.viewAll,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),

                SizedBox(height: 1.h),

                // Subtitle
                Text(
                  AppLocalizations.of(context)!.seeMoreAreas,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),

                SizedBox(height: 6.h),

                // Action indicator
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 7.sp,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
