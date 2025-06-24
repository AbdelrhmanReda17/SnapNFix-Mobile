import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/area_card.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/see_all_card.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class SubscribedAreasListWidget extends StatelessWidget {
  final List<AreaInfo> subscribedAreas;
  final bool isRefreshing;
  final ColorScheme colorScheme;
  final bool hasError;
  final VoidCallback? onSeeAll;

  const SubscribedAreasListWidget({
    super.key,
    required this.subscribedAreas,
    required this.isRefreshing,
    required this.colorScheme,
    this.hasError = false,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (hasError)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            margin: EdgeInsets.only(bottom: 8.h),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16.sp,
                  color: colorScheme.onErrorContainer,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Showing cached data',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: subscribedAreas.length + 1, // +1 for "See All" card
            itemBuilder: (context, index) {
              if (index == subscribedAreas.length) {
                // "See All" card
                return SeeAllCard(
                  colorScheme: colorScheme,
                  onTap: onSeeAll,
                );
              }
              
              final area = subscribedAreas[index];
              return AreaCard(
                area: area,
                colorScheme: colorScheme,
                onTap: () {
                  context.push(
                    Routes.areaIssuesChat,
                    extra: area,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
