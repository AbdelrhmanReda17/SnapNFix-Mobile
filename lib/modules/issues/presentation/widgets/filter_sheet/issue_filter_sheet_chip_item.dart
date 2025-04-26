import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueFilterSheetChipItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;
  final ColorScheme colorScheme;
  final Color? chipColor;

  const IssueFilterSheetChipItem({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    required this.colorScheme,
    this.chipColor,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color:
              isSelected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
          fontSize: 14.sp,
        ),
      ),
      selected: isSelected,
      onSelected: onSelected,
      backgroundColor: colorScheme.surfaceVariant,
      selectedColor: chipColor ?? colorScheme.primary,
      checkmarkColor: colorScheme.onPrimary,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(
          color:
              isSelected
                  ? Colors.transparent
                  : colorScheme.outline.withOpacity(0.5),
        ),
      ),
    );
  }
}
