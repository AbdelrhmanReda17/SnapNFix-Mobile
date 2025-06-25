import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';

class AreaCard extends StatelessWidget {
  final AreaInfo area;
  final bool isSubscribed;
  final VoidCallback? onSubscriptionToggle;
  final VoidCallback? onTap;
  final bool showSubscriptionButton;

  const AreaCard({
    super.key,
    required this.area,
    this.isSubscribed = false,
    this.onSubscriptionToggle,
    this.onTap,
    this.showSubscriptionButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          area.name,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          area.state,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showSubscriptionButton) _buildSubscriptionButton(context),
                ],
              ),
              SizedBox(height: 12.h),
              _buildIssuesCount(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionButton(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onSubscriptionToggle,
      style: FilledButton.styleFrom(
        backgroundColor:
            isSubscribed
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                : Theme.of(context).colorScheme.surfaceVariant,
        foregroundColor:
            isSubscribed
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSubscribed ? Icons.notifications : Icons.notifications_none,
            size: 16.sp,
          ),
          SizedBox(width: 4.w),
          Text(
            isSubscribed ? 'Subscribed' : 'Subscribe',
            style: TextStyle(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildIssuesCount(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: _getIssuesCountColor(context),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_rounded,
            size: 16.sp,
            color: _getIssuesCountTextColor(context),
          ),
          SizedBox(width: 4.w),
          Text(
            '${area.activeIssuesCount} Active Issues',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: _getIssuesCountTextColor(context),
            ),
          ),
        ],
      ),
    );
  }

  Color _getIssuesCountColor(BuildContext context) {
    if (area.activeIssuesCount == 0) {
      return Theme.of(context).colorScheme.primaryContainer;
    } else if (area.activeIssuesCount <= 5) {
      return Theme.of(context).colorScheme.tertiaryContainer;
    } else if (area.activeIssuesCount <= 15) {
      return Theme.of(context).colorScheme.secondaryContainer;
    } else {
      return Theme.of(context).colorScheme.errorContainer;
    }
  }

  Color _getIssuesCountTextColor(BuildContext context) {
    if (area.activeIssuesCount == 0) {
      return Theme.of(context).colorScheme.onPrimaryContainer;
    } else if (area.activeIssuesCount <= 5) {
      return Theme.of(context).colorScheme.onTertiaryContainer;
    } else if (area.activeIssuesCount <= 15) {
      return Theme.of(context).colorScheme.onSecondaryContainer;
    } else {
      return Theme.of(context).colorScheme.onErrorContainer;
    }
  }
}
