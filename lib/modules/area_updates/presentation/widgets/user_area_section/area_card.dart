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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with issues count
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: _getIssueCountColor().withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getIssueIcon(),
                            size: 10.sp,
                            color: _getIssueCountColor(),
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            '${area.activeIssuesCount}',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: _getIssueCountColor(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.location_on_rounded,
                      size: 14.sp,
                      color: colorScheme.primary.withValues(alpha: 0.6),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Area info - takes remaining space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        area.name.isNotEmpty
                            ? area.name
                            : AppLocalizations.of(context)!.unknownArea,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSurface,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(
                            Icons.place_outlined,
                            size: 9.sp,
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
                                fontSize: 9.sp,
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

                SizedBox(height: 6.h),

                // Action indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 8.sp,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
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
