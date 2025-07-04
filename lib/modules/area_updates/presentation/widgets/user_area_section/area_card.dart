import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';

class AreaCard extends StatelessWidget {
  final AreaInfo area;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const AreaCard({
    super.key,
    required this.area,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth =
        (screenWidth - 48.w) / 2.8; // More responsive width calculation

    return Container(
      width: cardWidth.clamp(
        120.w,
        160.w,
      ), // Constrain within reasonable bounds
      constraints: BoxConstraints(minHeight: 100.h, maxHeight: 140.h),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with issues count
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: _getIssueCountColor().withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getIssueIcon(),
                              size: 8.sp,
                            color: _getIssueCountColor(),
                          ),
                            SizedBox(width: 2.w),
                          Text(
                            '${area.activeIssuesCount}',
                            style: TextStyle(
                                fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                              color: _getIssueCountColor(),
                            ),
                          ),
                        ],
                        ),
                      ),
                    ),
                    Icon(
                      Icons.location_on_rounded,
                      size: 12.sp,
                      color: colorScheme.primary.withValues(alpha: 0.6),
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                // Area info - takes remaining space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                        area.name.isNotEmpty
                            ? area.name
                            : AppLocalizations.of(context)!.unknownArea,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSurface,
                            height: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.place_outlined,
                            size: 8.sp,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Text(
                              area.state.isNotEmpty
                                  ? area.state
                                  : AppLocalizations.of(context)!.unknownState,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 4.h),

                // Action indicator
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(3.w),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getIssueCountColor() {
    if (area.activeIssuesCount == 0) {
      return colorScheme.primary;
    } else if (area.activeIssuesCount <= 5) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  IconData _getIssueIcon() {
    if (area.activeIssuesCount == 0) {
      return Icons.check_circle_outline_rounded;
    } else if (area.activeIssuesCount <= 5) {
      return Icons.warning_amber_rounded;
    } else {
      return Icons.error_outline_rounded;
    }
  }
}
