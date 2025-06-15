import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';
import 'package:snapnfix/modules/reports/data/models/snap_report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/location_display.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';
import 'package:snapnfix/presentation/widgets/issue_severity_icons_indicator.dart';

class ReportExpandedContent extends StatelessWidget {
  final SnapReportModel report;
  final Animation<double> expandAnimation;

  const ReportExpandedContent({
    super.key,
    required this.report,
    required this.expandAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: LocationDisplay(
                  road: report.road,
                  city: report.city,
                  state: report.state,
                  country: report.country,
                ),
              ),
            ],
          ),
          verticalSpace(4),
          if (report.severity != null) ...[
            Row(
              children: [
                Text(
                  localization.reportSeverity(''),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                horizontalSpace(8),
                IssueSeverityIconsIndicator(
                  severity: _mapReportSeverityToIssueSeverity(report.severity!),
                  iconSize: 16,
                  showLabel: true,
                  spacing: 6,
                ),
              ],
            ),
            verticalSpace(8),
          ],
          SizeTransition(
            sizeFactor: expandAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (report.comment != null) ...[
                  Text(
                    report.comment ?? '',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],
                if (report.issueId != null) ...[
                  verticalSpace(8),
                  InkWell(
                    onTap: () {
                      context.push(Routes.issueDetails, extra: report.issueId);
                    },
                    child: Text(
                      "View Issue",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  IssueSeverity _mapReportSeverityToIssueSeverity(ReportSeverity severity) {
    return switch (severity) {
      ReportSeverity.notSpecified => IssueSeverity.notSpecified,
      ReportSeverity.low => IssueSeverity.low,
      ReportSeverity.medium => IssueSeverity.medium,
      ReportSeverity.high => IssueSeverity.high,
    };
  }
}
