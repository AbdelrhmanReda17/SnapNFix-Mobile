import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/marker_dialog/issue_marker_dialog_detail_item.dart';

class IssueDetails extends StatelessWidget {
  final Issue issue;
  const IssueDetails({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.all(16.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  localization.issueCategory(issue.category.displayName),
                  style: textStyles.headlineMedium?.copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Severity
              Expanded(
                flex: 2,
                child: IssueMarkerDialogDetailItem(
                  icon: issue.severity.icon,
                  text: localization.issueSeverity(issue.severity.toString()),
                  color: issue.severity.color,
                  iconTextSpacing: 2.w,
                ),
              ),
              horizontalSpace(8),
              // Status
              Expanded(
                flex: 3,
                child: IssueMarkerDialogDetailItem(
                  icon: issue.status.icon,
                  text: localization.issueStatus(issue.status.toString()),
                  color: issue.status.color,
                  iconTextSpacing: 2.w,
                ),
              ),
            ],
          ),

          verticalSpace(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Number of reports
              Expanded(
                child: IssueMarkerDialogDetailItem(
                  icon: Icons.report_problem_rounded,
                  text: localization.issueReportsNum(issue.reportsCount),
                  color: colorScheme.secondary,
                  iconTextSpacing: 4.w,
                ),
              ),
              horizontalSpace(6),
              Expanded(
                child: IssueMarkerDialogDetailItem(
                  icon: Icons.location_on_outlined,
                  text: localization.issueLocation(
                    '${issue.road}, ${issue.city}, ${issue.state}, ${issue.country}',
                  ),
                  color: colorScheme.secondary,
                  iconTextSpacing: 2.w,
                ),
              ),
              horizontalSpace(6),
              Expanded(
                child: IssueMarkerDialogDetailItem(
                  icon: Icons.calendar_today_outlined,
                  text: localization.issuedAt(
                    DateFormat('MMM d, yyyy').format(issue.createdAt),
                  ),
                  color: colorScheme.secondary,
                  iconTextSpacing: 2.w,
                ),
              ),
            ],
          ),

          verticalSpace(16),
          // Descriptionss section header
          // Text(
          //   localization.issueDescriptionsTitle(issue.descriptions.length),
          //   style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          // ),
        ],
      ),
    );
  }
}
