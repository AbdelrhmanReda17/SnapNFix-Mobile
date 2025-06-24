import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionLoadingWidget extends StatelessWidget {
  const SubscriptionLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class AreasLoadingWidget extends StatelessWidget {
  const AreasLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class GeneralErrorWidget extends StatelessWidget {
  final String message;
  final ColorScheme colorScheme;
  final VoidCallback? onRetry;

  const GeneralErrorWidget({
    super.key,
    required this.message,
    required this.colorScheme,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: colorScheme.errorContainer.withOpacity(0.3),
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: colorScheme.error),
          SizedBox(height: 12.h),
          Text(
            'Failed to Load Areas',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onErrorContainer,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: colorScheme.onErrorContainer.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 16.h),
          if (onRetry != null)
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
        ],
      ),
    );
  }
}
