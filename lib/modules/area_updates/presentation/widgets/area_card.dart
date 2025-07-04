import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';

class AreaCard extends StatelessWidget {
  final AreaInfo area;
  final bool isSubscribed;
  final VoidCallback? onSubscriptionToggle;
  final VoidCallback? onTap;
  final bool showSubscriptionButton;
  final bool isLoading;

  const AreaCard({
    super.key,
    required this.area,
    this.isSubscribed = false,
    this.onSubscriptionToggle,
    this.onTap,
    this.showSubscriptionButton = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.location_city,
                    size: 24.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        area.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14.sp,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              area.state,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      _buildIssuesCount(context),
                    ],
                  ),
                ),
                if (showSubscriptionButton) _buildSubscriptionButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onSubscriptionToggle,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color:
                  isSubscribed
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 14.sp,
                    height: 14.sp,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color:
                          isSubscribed
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  )
                else
                  Icon(
                    isSubscribed ? Icons.check : Icons.add,
                    size: 16.sp,
                    color:
                        isSubscribed
                            ? Colors.white
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                SizedBox(width: 6.w),
                Flexible(
                  child: Text(
                    isLoading
                        ? (isSubscribed
                            ? AppLocalizations.of(context)!.removing
                            : AppLocalizations.of(context)!.adding)
                        : (isSubscribed
                            ? AppLocalizations.of(context)!.subscribed
                            : AppLocalizations.of(context)!.subscribe),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color:
                          isSubscribed
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIssuesCount(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _getIssuesCountColor(context),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getIssuesIcon(), size: 12.sp, color: Colors.white),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              '${area.activeIssuesCount} ${area.activeIssuesCount == 1 ? AppLocalizations.of(context)!.issue : AppLocalizations.of(context)!.issuesPlural}',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Color _getIssuesCountColor(BuildContext context) {
    if (area.activeIssuesCount == 0) {
      return Colors.green;
    } else if (area.activeIssuesCount <= 5) {
      return Colors.orange;
    } else if (area.activeIssuesCount <= 15) {
      return Colors.deepOrange;
    } else {
      return Colors.red;
    }
  }

  IconData _getIssuesIcon() {
    if (area.activeIssuesCount == 0) {
      return Icons.check_circle;
    } else if (area.activeIssuesCount <= 5) {
      return Icons.warning;
    } else {
      return Icons.error;
    }
  }
}
