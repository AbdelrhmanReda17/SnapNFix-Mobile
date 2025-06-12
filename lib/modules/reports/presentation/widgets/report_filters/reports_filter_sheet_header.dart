import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';

class ReportsFilterSheetHeader extends StatelessWidget {
  final VoidCallback onClearFilters;
  final bool hasFilters;

  const ReportsFilterSheetHeader({
    super.key,
    required this.onClearFilters,
    required this.hasFilters,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
           "Filter Reports",
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
                horizontalSpace(4),
                Text(localization.clearAll, style: TextStyle(fontSize: 14.sp)),
              ],
            ),
          ),
      ],
    );
  }
}