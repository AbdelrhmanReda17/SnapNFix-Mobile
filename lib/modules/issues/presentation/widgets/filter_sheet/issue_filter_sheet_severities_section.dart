import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';
import 'issue_filter_sheet_chip_item.dart';
import 'issue_filter_sheet_section_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IssueFilterSheetSeveritiesSection extends StatelessWidget {
  final List<IssueSeverity> selectedSeverities;
  final Function(IssueSeverity, bool) onToggleSeverity;

  const IssueFilterSheetSeveritiesSection({
    super.key,
    required this.selectedSeverities,
    required this.onToggleSeverity,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IssueFilterSheetSectionTitle(title: localization.severities),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children:
              IssueSeverity.values
                  .map(
                    (severity) => IssueFilterSheetChipItem(
                      label: severity.displayName,
                      isSelected: selectedSeverities.contains(severity),
                      onSelected:
                          (selected) => onToggleSeverity(severity, selected),
                      colorScheme: colorScheme,
                      chipColor: severity.color,
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
