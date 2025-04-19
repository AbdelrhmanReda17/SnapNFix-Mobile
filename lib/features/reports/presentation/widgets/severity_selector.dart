import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/features/reports/presentation/screens/add_report_screen.dart';

import '../../data/models/report_severity.dart';

class SeveritySelector extends StatefulWidget {
  const SeveritySelector({super.key});

  @override
  State<SeveritySelector> createState() => _SeveritySelectorState();
}

class _SeveritySelectorState extends State<SeveritySelector> {
  ReportSeverity _selectedSeverity = ReportSeverity.low;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Severity',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: colorScheme.primary),
        ),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final severity in ReportSeverity.values) ...[
              _buildSeverityButton(severity),
              if (severity != ReportSeverity.values.last) ...[
                SizedBox(width: 8.w),
              ],
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildSeverityButton(ReportSeverity severity) {
    final isSelected = _selectedSeverity == severity;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedSeverity = severity),
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
