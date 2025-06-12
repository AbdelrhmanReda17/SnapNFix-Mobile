import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/reports/data/models/report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/location_display.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class ReportExpandedContent extends StatelessWidget {
  final ReportModel report;
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
                  latitude: report.latitude,
                  longitude: report.longitude,
                ),
              ),
            ],
          ),
          verticalSpace(4),
          if (report.severity != null)
            Text(
              localization.reportSeverity(
                _getSeverityText(report.severity!, localization),
              ),
              style: theme.textTheme.bodySmall?.copyWith(
                color: report.severity!.color,
                fontWeight: FontWeight.w500,
              ),
            ),
          verticalSpace(4),
          SizeTransition(
            sizeFactor: expandAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (report.details != null) ...[
                  Text(
                    report.details ?? '',
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
                      localization.viewIssue(report.issueId!),
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

  String _getSeverityText(
    ReportSeverity severity,
    AppLocalizations localization,
  ) {
    return switch (severity) {
      ReportSeverity.low => localization.severityLow,
      ReportSeverity.medium => localization.severityMedium,
      ReportSeverity.high => localization.severityHigh,
    };
  }
}
