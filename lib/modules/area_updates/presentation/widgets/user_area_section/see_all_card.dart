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
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 48.w) / 2.8; // More responsive width calculation
    
    return Container(
      width: cardWidth.clamp(120.w, 160.w), // Constrain within reasonable bounds
      constraints: BoxConstraints(
        minHeight: 100.h,
        maxHeight: 140.h,
      ),
      margin: EdgeInsets.only(right: 12.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: colorScheme.surfaceContainer,
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: .1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.15),
                  spreadRadius: isDarkMode ? 0.5 : 0,
                  blurRadius: isDarkMode ? 2 : 1,
                  offset: Offset(0, isDarkMode ? 1 : 0.5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon with background
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.grid_view_rounded,
                    size: 14.sp,
                    color: colorScheme.primary,
                  ),
                ),

                SizedBox(height: 4.h),

                // Text
                Flexible(
                  child: Text(
                    AppLocalizations.of(context)!.viewAll,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),

                SizedBox(height: 2.h),

                // Subtitle
                Flexible(
                  child: Text(
                    AppLocalizations.of(context)!.seeMoreAreas,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 7.sp,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),

                SizedBox(height: 4.h),

                // Action indicator
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 6.sp,
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
