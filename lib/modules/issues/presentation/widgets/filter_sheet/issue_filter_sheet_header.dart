import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueFilterSheetHeader extends StatelessWidget {
  final VoidCallback onClearFilters;
  final bool hasFilters;

  const IssueFilterSheetHeader({
    super.key,
    required this.onClearFilters,
    required this.hasFilters,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Filter Issues',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        if (hasFilters)
          TextButton(
            onPressed: onClearFilters,
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.error,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              visualDensity: VisualDensity.compact,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.clear, size: 16.r, color: colorScheme.error),
                SizedBox(width: 4.w),
                Text('Clear All', style: TextStyle(fontSize: 14.sp)),
              ],
            ),
          ),
      ],
    );
  }
}
