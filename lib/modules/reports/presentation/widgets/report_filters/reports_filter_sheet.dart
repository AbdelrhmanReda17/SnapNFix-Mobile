import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/report_review_cubit.dart';

class ReportsFilterSheet extends StatefulWidget {
  final ReportStatus? selectedStatus;
  final IssueCategory? selectedCategory;

  const ReportsFilterSheet({
    super.key, 
    this.selectedStatus,
    this.selectedCategory,
  });

  @override
  State<ReportsFilterSheet> createState() => _ReportsFilterSheetState();
}

class _ReportsFilterSheetState extends State<ReportsFilterSheet> {
  ReportStatus? _selectedStatus;
  IssueCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.selectedStatus;
    _selectedCategory = widget.selectedCategory;
  }

  void _selectStatus(ReportStatus? status) {
    setState(() {
      // Toggle if already selected
      if (_selectedStatus == status) {
        _selectedStatus = null;
      } else {
        _selectedStatus = status;
      }
    });
  }

  void _selectCategory(IssueCategory? category) {
    setState(() {
      // Toggle if already selected
      if (_selectedCategory == category) {
        _selectedCategory = null;
      } else {
        _selectedCategory = category;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.filter_list, size: 20.sp, color: colorScheme.primary),
                    SizedBox(width: 8.w),
                    Text(
                      localization.filters,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (_selectedStatus != null || _selectedCategory != null)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedStatus = null;
                            _selectedCategory = null;
                          });
                        },
                        child: Text(
                          localization.clearFilters,
                          style: TextStyle(
                            color: colorScheme.error,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, size: 20.sp),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1.h, thickness: 1.h),

          // Scrollable content
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Filter
                    _buildFilterSection(
                      title: localization.status,
                      child: Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: ReportStatus.values.map((status) {
                          final isSelected = _selectedStatus == status;
                          return _buildFilterChip(
                            label: status.value,
                            isSelected: isSelected,
                            color: status.color,
                            onSelected: () => _selectStatus(status),
                          );
                        }).toList(),
                      ),
                    ),

                    // Category Filter
                    _buildFilterSection(
                      title: localization.category,
                      child: Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: IssueCategory.values.map((category) {
                          final isSelected = _selectedCategory == category;
                          return _buildFilterChip(
                            label: category.displayName,
                            isSelected: isSelected,
                            color: colorScheme.primary,
                            onSelected: () => _selectCategory(category),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: 16.h),
                    
                    // Apply button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<ReportReviewCubit>().applyFilters(
                            status: _selectedStatus,
                            category: _selectedCategory,
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          localization.applyFilters,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 24.h + MediaQuery.of(context).padding.bottom),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection({required String title, required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required Color color,
    required VoidCallback onSelected,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSelected,
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.15) : colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: isSelected ? color : colorScheme.outline.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected)
                Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: Icon(
                    Icons.check,
                    size: 16.sp,
                    color: color,
                  ),
                ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? color : colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}