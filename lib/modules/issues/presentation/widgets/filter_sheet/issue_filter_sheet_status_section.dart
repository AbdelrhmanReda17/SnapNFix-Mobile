import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';
import 'issue_filter_sheet_chip_item.dart';
import 'issue_filter_sheet_section_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IssueFilterSheetStatusSection extends StatelessWidget {
  final List<IssueStatus> selectedStatuses;
  final Function(IssueStatus, bool) onToggleStatus;

  const IssueFilterSheetStatusSection({
    super.key,
    required this.selectedStatuses,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IssueFilterSheetSectionTitle(title: localization.status),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children:
              IssueStatus.values
                  .map(
                    (status) => IssueFilterSheetChipItem(
                      label: status.displayName,
                      isSelected: selectedStatuses.contains(status),
                      onSelected:
                          (selected) => onToggleStatus(status, selected),
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
