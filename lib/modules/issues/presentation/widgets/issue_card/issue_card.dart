import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/issue_card/issue_detail_item.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/issue_card/issue_image.dart';
import 'package:snapnfix/presentation/widgets/issue_severity_icons_indicator.dart';

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
    final colorScheme = theme.colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 3,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.2),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            IssueImage(
              imageUrl: issue.images.isNotEmpty ? issue.images.first : null,
              height: 140,
              borderRadius: 0,
              issue: issue,
            ),
            Padding(
              padding: EdgeInsets.all(12.h),
              child: Column(
                children: [
                  // First row with report count and severity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IssueDetailItem(
                        icon: Icons.people,
                        text: localization.issueReportsNum(issue.reportsCount),
                        color: colorScheme.secondary,
                        padding: EdgeInsets.symmetric(
                          vertical: 6.h,
                          horizontal: 8.w,
                        ),
                        borderRadius: 20,
                      ),
                      IssueSeverityIconsIndicator(
                        severity: issue.severity,
                        iconSize: 16,
                        showLabel: true,
                        spacing: 6,
                      ),
                    ],
                  ),

                  if (showReportButton) ...[
                    verticalSpace(12),
                    SizedBox(
                      width: double.infinity,
                      child: BaseButton(
                        onPressed: onReportTap,
                        text: localization.reportNow,
                        backgroundColor: theme.colorScheme.primary,
                        textStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onPrimary,
                        ),
                        borderRadius: 8.r,
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
