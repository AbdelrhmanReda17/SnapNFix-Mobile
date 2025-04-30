import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    final imagePath = 'assets/images/issue${(int.parse(widget.report.id) % 3) + 1}.jpg';

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
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
                      height: 100.h,
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
                          color: _getStatusColor(widget.report.status).withOpacity(0.9),
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
                              widget.report.status.value.toUpperCase(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.surface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Date
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: colorScheme.surface.withOpacity(0.9),
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

                // Content section
                Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Location and severity row
                      Row(
                        children: [
                          Expanded(
                            child: LocationDisplay(
                              latitude: widget.report.latitude,
                              longitude: widget.report.longitude,
                              // style: theme.textTheme.labelSmall?.copyWith(
                              //   color: colorScheme.onSurfaceVariant,
                              // ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: _getSeverityColor(widget.report.severity).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              widget.report.severity.name.toUpperCase(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: _getSeverityColor(widget.report.severity),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        widget.report.details,
                        maxLines: _isExpanded ? null : 2,
                        overflow: _isExpanded ? null : TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
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

  String _formatDate(String timestamp) {
    final date = DateTime.parse(timestamp);
    return '${date.day}/${date.month}/${date.year}';
  }
}
