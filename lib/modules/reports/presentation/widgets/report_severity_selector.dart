import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportSeveritySelector extends StatelessWidget {
  final ReportSeverity selectedSeverity;
  final ValueChanged<ReportSeverity> onSeverityChanged;
  final bool showLabel;
  final bool isMandatory;

  const ReportSeveritySelector({
    super.key,
    required this.selectedSeverity,
    required this.onSeverityChanged,
    this.showLabel = true,
    this.isMandatory = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.severity,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: colorScheme.primary,
                    fontWeight:
                        isMandatory ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (isMandatory)
                  TextSpan(
                    text: ' *',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          verticalSpace(5),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final severity in ReportSeverity.values) ...[
              if (severity != ReportSeverity.values.first) ...[
                _buildSeverityButton(severity, context),
                if (severity != ReportSeverity.values.last) ...[
                  horizontalSpace(8),
                ],
              ] else
                SizedBox.shrink(),
            ],
          ],
        ),
      ],
    );
  }
  Widget _buildSeverityButton(ReportSeverity severity, BuildContext context) {
    final isSelected = selectedSeverity == severity;
    final localization = AppLocalizations.of(context)!;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => onSeverityChanged(severity),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          decoration: BoxDecoration(
            color: isSelected ? severity.color : severity.backgroundColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isSelected ? severity.color : severity.borderColor,
            ),
          ),
          child: Center(
            child: Text(
              severity.getLocalizedName(localization),
              style: TextStyle(
                color: isSelected ? Colors.white : severity.color,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
