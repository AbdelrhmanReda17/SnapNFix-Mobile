import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';

class AreaListWidget extends StatelessWidget {
  final List<AreaInfo> areas;
  final ColorScheme colorScheme;
  final String title;
  final Function(String)? onToggleSubscription;
  final Function(String, AreaInfo)? onAreaTap;
  final bool Function(String)? isSubscribed;
  final bool showSubscriptionButton;
  final bool isLoading;

  const AreaListWidget({
    super.key,
    required this.areas,
    required this.colorScheme,
    required this.title,
    this.onToggleSubscription,
    this.onAreaTap,
    this.isSubscribed,
    this.showSubscriptionButton = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                if (isLoading) ...[
                  SizedBox(width: 8.w),
                  SizedBox(
                    width: 16.w,
                    height: 16.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),

        // Areas List
        if (areas.isEmpty) _buildEmptyState() else _buildAreasList(),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.location_off_outlined,
              size: 48.sp,
              color: colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: 12.h),
            Text(
              'No areas found',
              style: TextStyle(
                fontSize: 16.sp,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAreasList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: areas.length,
      itemBuilder: (context, index) {
        final area = areas[index];
        final isAreaSubscribed = isSubscribed?.call(area.id) ?? false;

        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: colorScheme.surface,
            border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 8.h,
            ),
            title: Text(
              area.name,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (area.state.isNotEmpty) ...[
                  Text(
                    area.state,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],
                Text(
                  '${area.activeIssuesCount} active issues',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color:
                        area.activeIssuesCount > 0
                            ? colorScheme.error
                            : colorScheme.onSurfaceVariant,
                    fontWeight:
                        area.activeIssuesCount > 0
                            ? FontWeight.w500
                            : FontWeight.normal,
                  ),
                ),
              ],
            ),
            trailing:
                showSubscriptionButton && onToggleSubscription != null
                    ? _buildSubscriptionButton(area, isAreaSubscribed)
                    : null,
            onTap: () => onAreaTap?.call(area.id, area),
          ),
        );
      },
    );
  }

  Widget _buildSubscriptionButton(AreaInfo area, bool isAreaSubscribed) {
    return GestureDetector(
      onTap: () => onToggleSubscription?.call(area.id),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: isAreaSubscribed ? colorScheme.primary : colorScheme.surface,
          border: Border.all(color: colorScheme.primary, width: 1),
        ),
        child: Text(
          isAreaSubscribed ? 'Subscribed' : 'Subscribe',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color:
                isAreaSubscribed ? colorScheme.onPrimary : colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
