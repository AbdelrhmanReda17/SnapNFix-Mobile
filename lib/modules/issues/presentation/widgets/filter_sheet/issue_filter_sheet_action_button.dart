import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueFilterSheetActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool hasFilters;
  final int filterCount;

  const IssueFilterSheetActionButton({
    super.key,
    required this.onPressed,
    this.hasFilters = false,
    this.filterCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 48.h,
        margin: EdgeInsets.only(top: 16.h),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            elevation: 0,
          ),
          child: Text(
            hasFilters
                ? '${localization.applyFilters} ($filterCount)'
                : '${localization.applyFilters}',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
