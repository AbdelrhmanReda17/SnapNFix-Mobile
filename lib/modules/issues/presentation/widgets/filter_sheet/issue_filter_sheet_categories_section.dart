import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'issue_filter_sheet_chip_item.dart';
import 'issue_filter_sheet_section_title.dart';

class IssueFilterSheetCategoriesSection extends StatelessWidget {
  final List<IssueCategory> selectedCategories;
  final Function(IssueCategory, bool) onToggleCategory;

  const IssueFilterSheetCategoriesSection({
    super.key,
    required this.selectedCategories,
    required this.onToggleCategory,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const IssueFilterSheetSectionTitle(title: 'Categories'),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children:
              IssueCategory.values
                  .map(
                    (category) => IssueFilterSheetChipItem(
                      label: category.displayName,
                      isSelected: selectedCategories.contains(category),
                      onSelected:
                          (selected) => onToggleCategory(category, selected),
                      colorScheme: colorScheme,
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
