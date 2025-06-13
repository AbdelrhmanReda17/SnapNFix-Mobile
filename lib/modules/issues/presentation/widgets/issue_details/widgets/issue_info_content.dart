import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
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
        Divider(color: colorScheme.outlineVariant.withOpacity(0.5)),
        SizedBox(height: 8.h),
        InfoItem(
          icon: Icons.warning_amber_rounded,
          text: 'Severity: ${localization.issueSeverity(issue.severity.toString())}',
          color: issue.severity.color,
        ),
        SizedBox(height: 12.h),
        InfoItem(
          icon: Icons.report_problem_rounded,
          text: 'Reports: ${localization.issueReportsNum(issue.reportsCount)}',
          color: colorScheme.secondary,
        ),
        SizedBox(height: 12.h),
        InfoItem(
          icon: Icons.calendar_today_outlined,
          text: 'Created: ${DateFormat('MMM d, yyyy').format(issue.createdAt)}',
          color: colorScheme.tertiary,
        ),
      ],
    );
  }
}