import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/issue_card/issue_detail_item.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/issue_card/issue_image.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/issue_card/issue_status_badge.dart';

class IssueCard extends StatelessWidget {
  final Issue issue;
  final VoidCallback? onTap;
  final bool showReportButton;
  final VoidCallback? onReportTap;

  const IssueCard({
    super.key,
    required this.issue,
    this.onTap,
    this.showReportButton = false,
    this.onReportTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;

    return Card(
      margin: EdgeInsets.only(bottom: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          children: [
            IssueImage(
              imageUrl: issue.images.isNotEmpty ? issue.images.first : null,
              height: 120,
              borderRadius: 12,
              overlay: Positioned(
                top: 8.r,
                right: 8.r,
                child: IssueStatusBadge(status: issue.status),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: IssueDetailItem(
                          icon: Icons.category,
                          text: issue.category.displayName,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: IssueDetailItem(
                          icon: Icons.report_problem_outlined,
                          text: localization.issueReportsNum(issue.reportsCount),
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  if (showReportButton) ...[
                    SizedBox(height: 12.h),
                    SizedBox(
                      width: double.infinity,
                      child: BaseButton(
                        onPressed: onReportTap,
                        text: localization.reportNow,
                        backgroundColor: theme.colorScheme.primary,
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}