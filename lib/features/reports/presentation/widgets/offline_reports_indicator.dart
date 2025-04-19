import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/features/reports/data/repository/offline_reports_repository.dart';

class OfflineReportsIndicator extends StatelessWidget {
  const OfflineReportsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final offlineReportsRepository = getIt<OfflineReportsRepository>();

    // Listen to changes in the pending reports count via ValueNotifier
    return ValueListenableBuilder<int>(
      valueListenable: offlineReportsRepository.pendingReportsCountNotifier,
      builder: (context, count, _) {
        // Don't show anything if there are no pending reports
        if (count <= 0) {
          return const SizedBox.shrink();
        }
        return Card(
          margin: EdgeInsets.all(16.r),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.cloud_upload,
                      color: colorScheme.primary,
                      size: 24.r,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'You have $count offline report${count > 1 ? 's' : ''} pending',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Reports will automatically be submitted when your network connection is restored.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
