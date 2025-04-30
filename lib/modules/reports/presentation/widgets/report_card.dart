import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/location_display.dart';

class ReportCard extends StatefulWidget {
  final ReportModel report;

  const ReportCard({super.key, required this.report});

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localization = AppLocalizations.of(context)!;

    final imagePath = 'assets/images/issue${(int.parse(widget.report.id) % 3) + 1}.jpg';

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r), 
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Column(
              children: [
                // Header with image
                Stack(
                  children: [
                    Image.asset(
                      imagePath,
                      height: 80.h, 
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    // Status indicator
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: _getStatusColor(widget.report.status).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6.w,
                              height: 6.w,
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              _getStatusText(widget.report.status, localization).toUpperCase(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.surface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: colorScheme.surface.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          _formatDate(widget.report.timestamp),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: LocationDisplay(
                              latitude: widget.report.latitude,
                              longitude: widget.report.longitude,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),

                      Text(
                        'Severity: ${_getSeverityText(widget.report.severity, localization)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: _getSeverityColor(widget.report.severity),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        widget.report.details,
                        maxLines: _isExpanded ? null : 2,
                        overflow: _isExpanded ? null : TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith( // Smaller text
                          color: colorScheme.onSurface,
                        ),
                      ),

                      // Issue link
                      if (widget.report.issueId != null) ...[
                        SizedBox(height: 8.h),
                        InkWell(
                          onTap: () {
                            // TODO: Navigate to issue detail screen
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => IssueDetailScreen(
                            //       issueId: widget.report.issueId!,
                            //     ),
                            //   ),
                            // );
                          },
                          child: Text(
                            localization.viewIssue(widget.report.issueId!),
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
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(ReportStatus status) {
    return switch (status) {
      ReportStatus.pending => Colors.orange,
      ReportStatus.valid => Colors.green,
      ReportStatus.invalid => Colors.red,
    };
  }

  Color _getSeverityColor(ReportSeverity severity) {
    return switch (severity) {
      ReportSeverity.low => Colors.blue,
      ReportSeverity.medium => Colors.orange,
      ReportSeverity.high => Colors.red,
    };
  }

  String _getSeverityText(ReportSeverity severity, AppLocalizations localization) {
    return switch (severity) {
      ReportSeverity.low => localization.severityLow,
      ReportSeverity.medium => localization.severityMedium,
      ReportSeverity.high => localization.severityHigh,
    };
  }

  String _getStatusText(ReportStatus status, AppLocalizations localization) {
    return switch (status) {
      ReportStatus.pending => localization.statusPending,
      ReportStatus.valid => localization.statusValid,
      ReportStatus.invalid => localization.statusInvalid,
    };
  }

  String _formatDate(String timestamp) {
    final date = DateTime.parse(timestamp);
    return '${date.day}/${date.month}/${date.year}';
  }
}
