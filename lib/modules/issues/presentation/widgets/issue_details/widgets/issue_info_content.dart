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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
        SizedBox(height: 8.h),
        InfoItem(
          icon: Icons.warning_amber_rounded,
          color: issue.severity.color,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${localization.severity}: ',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              IssueSeverityIconsIndicator(
                severity: issue.severity,
                iconSize: 16,
                showLabel: true,
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),        InfoItem(
          icon: Icons.people,
          text: '${localization.reportsLabel}: ${localization.issueReportsNum(issue.reportsCount)}',
          color: colorScheme.secondary,
        ),
        SizedBox(height: 12.h),
        InfoItem(
          icon: Icons.calendar_today_outlined,
          text: '${localization.createdLabel}: ${DateFormat('MMM d, yyyy').format(issue.createdAt)}',
          color: colorScheme.secondary,
        ),
      ],
    );
  }
}
