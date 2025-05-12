import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/location_display.dart';
import 'dart:io';

import 'package:snapnfix/presentation/navigation/routes.dart';

class ReportCard extends StatefulWidget {
  final ReportModel report;

  const ReportCard({super.key, required this.report});

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: _toggleExpand,
            child: Column(
              children: [
                // Header with image
                Stack(
                  children: [
                    Hero(
                      tag: 'report_image_${widget.report.id}',
                      child:
                          widget.report.image.uri.toString().isNotEmpty
                              ? (widget.report.image.uri.toString().startsWith(
                                        'http',
                                      ) ||
                                      widget.report.image.uri
                                          .toString()
                                          .startsWith('assets')
                                  ? Image.network(
                                    widget.report.image.uri.toString(),
                                    height: 80.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/issue1.jpg',
                                        height: 80.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                  : Image.file(
                                    File(widget.report.image.uri.toString()),
                                    height: 80.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/issue1.jpg',
                                        height: 80.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ))
                              : Image.asset(
                                'assets/images/issue1.jpg',
                                height: 80.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                    ),
                    // Status indicator
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: widget.report.status?.color.withValues(alpha: 0.8),
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
                            horizontalSpace(4),
                            Text(
                              _getStatusText(
                                widget.report.status!,
                                localization,
                              ).toUpperCase(),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surface.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          widget.report.dateString,
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
                      verticalSpace(4),

                      Text(
                        localization.reportSeverity(
                          _getSeverityText(
                            widget.report.severity!,
                            localization,
                          ),
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: widget.report.severity!.color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      verticalSpace(4),
                      SizeTransition(
                        sizeFactor: _expandAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.report.details != null) ...[
                              Text(
                                widget.report.details ?? '',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4.h),
                            ],
                            if (widget.report.issueId != null) ...[
                              verticalSpace(8),
                              InkWell(
                                onTap: () {
                                  context.push(
                                    Routes.issueDetails,
                                    extra: widget.report.issueId,
                                  );
                                },
                                child: Text(
                                  localization.viewIssue(
                                    widget.report.issueId!,
                                  ),
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

  Color _getStatusColor(ReportStatus status) {
    return switch (status) {
      ReportStatus.pending => Colors.orange,
      ReportStatus.verified => Colors.green,
      ReportStatus.rejected => Colors.red,
    };
  }

  String _getStatusText(ReportStatus status, AppLocalizations localization) {
    return switch (status) {
      ReportStatus.pending => localization.statusPending,
      ReportStatus.verified => localization.statusValid,
      ReportStatus.rejected => localization.statusInvalid,
    };
  }
}
