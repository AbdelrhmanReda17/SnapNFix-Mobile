import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'reports_filter_sheet_chip_item.dart';
import 'reports_filter_sheet_section_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportsFilterSheetCategoriesSection extends StatelessWidget {
  final IssueCategory? selectedCategory;
  final Function(IssueCategory?, bool) onToggleCategory;

  const ReportsFilterSheetCategoriesSection({
    super.key,
    required this.selectedCategory,
    required this.onToggleCategory,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReportsFilterSheetSectionTitle(title: localization.categories),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children:
              IssueCategory.values
                  .map(
                    (category) => ReportsFilterSheetChipItem(
                      label: category.displayName,
                      isSelected: selectedCategory == category,
                      onSelected:
                          (selected) => onToggleCategory(
                            selected ? category : null,
                            selected
                          ),
                      colorScheme: colorScheme,
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}