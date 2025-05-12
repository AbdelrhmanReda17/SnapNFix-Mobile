import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_report_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubmitSeveritySelector extends StatelessWidget {
  const SubmitSeveritySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SubmitReportCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.severity,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: colorScheme.primary),
        ),
        verticalSpace(5),
        BlocBuilder<SubmitReportCubit, SubmitReportState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (final severity in ReportSeverity.values) ...[
                  _buildSeverityButton(severity, state.severity, cubit),
                  if (severity != ReportSeverity.values.last) ...[
                    horizontalSpace(8),
                  ],
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildSeverityButton(
    ReportSeverity severity,
    ReportSeverity selectedSeverity,
    SubmitReportCubit cubit,
  ) {
    final isSelected = selectedSeverity == severity;
    return Expanded(
      child: GestureDetector(
        onTap: () => cubit.setSeverity(severity),
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
              severity.displayName,
              style: TextStyle(
                color: isSelected ? Colors.white : severity.color,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
