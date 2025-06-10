import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';

class ReportStatusIndicator extends StatelessWidget {
  final ReportStatus status;

  const ReportStatusIndicator({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.8),
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
            _getStatusText(status, localization).toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colorScheme.surface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusText(ReportStatus status, AppLocalizations localization) {
    return switch (status) {
      ReportStatus.pending => localization.statusPending,
      ReportStatus.approved => localization.statusValid,
      ReportStatus.declined => localization.statusInvalid,
    };
  }
}