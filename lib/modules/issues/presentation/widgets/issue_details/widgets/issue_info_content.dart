import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/presentation/widgets/issue_severity_icons_indicator.dart';
import './info_item.dart';

class IssueInfoContent extends StatelessWidget {
  final Issue issue;
  final ColorScheme colorScheme;
  final AppLocalizations localization;

  const IssueInfoContent({
    super.key,
    required this.issue,
    required this.colorScheme,
    required this.localization,
  });
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
          height: isTablet ? 16.h : 12.h,
        ),
        SizedBox(height: isTablet ? 6.h : 4.h),
        InfoItem(
          icon: Icons.warning_amber_rounded,
          color: isDarkMode ? colorScheme.primary : colorScheme.secondary,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${localization.severity}: ',
                style: TextStyle(
                  fontSize: isTablet ? 14.sp : 13.sp,
                  color:
                      isDarkMode ? colorScheme.primary : colorScheme.secondary,
                  height: 1.3,
                ),
              ),
              IssueSeverityIconsIndicator(
                severity: issue.severity,
                iconSize: isTablet ? 16 : 14,
                showLabel: true,
              ),
            ],
          ),
        ),
        SizedBox(height: isTablet ? 10.h : 8.h),
        InfoItem(
          icon: Icons.people,
          label: localization.reportsLabel,
          value: localization.issueReportsNum(issue.reportsCount),
          color: isDarkMode ? colorScheme.primary : colorScheme.secondary,
        ),
        SizedBox(height: isTablet ? 10.h : 8.h),
        InfoItem(
          icon: Icons.calendar_today_outlined,
          label: localization.createdLabel,
          value: DateFormat('MMM d, yyyy').format(issue.createdAt),
          color: isDarkMode ? colorScheme.primary : colorScheme.secondary,
        ),
      ],
    );
  }
}
