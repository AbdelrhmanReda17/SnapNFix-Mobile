import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';

class AreaTile extends StatelessWidget {
  final AreaInfo area;
  final bool isSubscribed;
  final ColorScheme colorScheme;
  final VoidCallback? onToggleSubscription;

  const AreaTile({
    super.key,
    required this.area,
    required this.isSubscribed,
    required this.colorScheme,
    this.onToggleSubscription,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onToggleSubscription,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: isSubscribed
                ? colorScheme.primaryContainer.withOpacity(0.7)
                : colorScheme.surfaceVariant.withOpacity(0.5),
            border: Border.all(
              color: isSubscribed
                  ? colorScheme.primary
                  : colorScheme.outline.withOpacity(0.3),
              width: isSubscribed ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: isSubscribed ? colorScheme.primary : colorScheme.outline,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    area.displayName[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: isSubscribed
                          ? colorScheme.onPrimary
                          : colorScheme.surface,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                area.displayName,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isSubscribed
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 4.h),
              Icon(
                isSubscribed ? Icons.check_circle : Icons.add_circle_outline,
                size: 20.sp,
                color: isSubscribed
                    ? colorScheme.primary
                    : colorScheme.onSurface.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
