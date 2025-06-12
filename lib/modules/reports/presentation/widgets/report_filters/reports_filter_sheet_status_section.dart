import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';
import 'reports_filter_sheet_chip_item.dart';
import 'reports_filter_sheet_section_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportsFilterSheetStatusSection extends StatelessWidget {
  final ReportStatus? selectedStatus;
  final Function(ReportStatus?, bool) onToggleStatus;

  const ReportsFilterSheetStatusSection({
    super.key,
    required this.selectedStatus,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReportsFilterSheetSectionTitle(title: localization.status),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children:
              ReportStatus.values
                  .map(
                    (status) => ReportsFilterSheetChipItem(
                      label: status.value,
                      isSelected: selectedStatus == status,
                      onSelected:
                          (selected) => onToggleStatus(
                            selected ? status : null, 
                            selected
                          ),
                      colorScheme: colorScheme,
                      chipColor: status.color,
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}