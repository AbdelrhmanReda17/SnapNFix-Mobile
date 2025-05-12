import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'issue_marker_dialog_detail_item.dart';
import 'issue_marker_dialog_action.dart';
import '../../../domain/entities/issue.dart';

class IssueMarkerDialogContent extends StatelessWidget {
  final Issue issue;
  final VoidCallback? onReportTap;

  const IssueMarkerDialogContent({
    super.key,
    required this.issue,
    this.onReportTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: IssueMarkerDialogDetailItem(
                  icon: Icons.category,
                  text: issue.category.displayName,
                  color: colorScheme.primary,
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: IssueMarkerDialogDetailItem(
                  icon: Icons.report_problem_outlined,
                  text: localization.issueReportsNum(issue.reportsCount),
                  color: colorScheme.secondary,
                ),
              ),
            ],
          ),
          verticalSpace(16),
          IssueMarkerDialogAction(onTap: onReportTap),
        ],
      ),
    );
  }
}