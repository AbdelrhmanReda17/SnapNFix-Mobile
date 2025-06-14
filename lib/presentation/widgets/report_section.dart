import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportSection extends StatelessWidget {
  const ReportSection({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [          Text(
            localization.spottedIssue,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : theme.colorScheme.primary,
            ),
          ),
          verticalSpace(3),
          Text(
            localization.helpUsImprove,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              height: 1.2.h,
            ),
          ),
          verticalSpace(8),
          Center(
            child: ElevatedButton(
              onPressed: () => context.go(Routes.submitReport),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: Container(
                decoration: BoxDecoration(
                  // Use solid color in dark mode, gradient in light mode
                  color: isDarkMode ? theme.colorScheme.primary : null,
                  gradient: isDarkMode ? null : LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      const Color(0xFF23576D)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      localization.reportNow,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    horizontalSpace(8),
                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 16.r,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
