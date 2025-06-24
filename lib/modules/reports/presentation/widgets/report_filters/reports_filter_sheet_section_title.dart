import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportsFilterSheetSectionTitle extends StatelessWidget {
  final String title;

  const ReportsFilterSheetSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    bool isDarkMode = colorScheme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? colorScheme.onPrimary : colorScheme.secondary,
        ),
      ),
    );
  }
}
