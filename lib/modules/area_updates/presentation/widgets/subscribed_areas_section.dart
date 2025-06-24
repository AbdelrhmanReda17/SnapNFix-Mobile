import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/subscribed_area_chip.dart';

class SubscribedAreasSection extends StatelessWidget {
  final List<AreaInfo> subscribedAreas;
  final ColorScheme colorScheme;
  final bool hasError;
  final Function(String) onUnsubscribe;

  const SubscribedAreasSection({
    super.key,
    required this.subscribedAreas,
    required this.colorScheme,
    required this.onUnsubscribe,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Your Subscriptions',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            if (hasError) ...[
              SizedBox(width: 8.w),
              Icon(
                Icons.warning_amber_rounded,
                size: 16.sp,
                color: colorScheme.error,
              ),
            ],
          ],
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: subscribedAreas.map((area) {
            return SubscribedAreaChip(
              areaName: area.displayName,
              colorScheme: colorScheme,
              onUnsubscribe: () => onUnsubscribe(area.name),
            );
          }).toList(),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
