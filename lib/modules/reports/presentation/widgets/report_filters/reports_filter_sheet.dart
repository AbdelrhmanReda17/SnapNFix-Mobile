import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/user_reports_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_filters/reports_filter_sheet_action_button.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_filters/reports_filter_sheet_categories_section.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_filters/reports_filter_sheet_header.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_filters/reports_filter_sheet_status_section.dart';

class ReportsFilterSheet extends StatefulWidget {
  final ReportStatus? selectedStatus;
  final IssueCategory? selectedCategory;
  final Function(ReportStatus?, IssueCategory?) onApply;

  const ReportsFilterSheet({
    super.key,
    this.selectedStatus,
    this.selectedCategory,
    required this.onApply,
  });

  static Future<void> show(BuildContext context) {
    final reportsCubit = context.read<UserReportsCubit>();
    final state = reportsCubit.state;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => ReportsFilterSheet(
            selectedStatus: state.currentStatus,
            selectedCategory: state.currentCategory,
            onApply: (status, category) {
              reportsCubit.loadReports(
                status: status,
                category: category,
                refresh: true,
              );
            },
          ),
    );
  }

  @override
  State<ReportsFilterSheet> createState() => _ReportsFilterSheetState();
}

class _ReportsFilterSheetState extends State<ReportsFilterSheet> {
  late ReportStatus? selectedStatus;
  late IssueCategory? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.selectedStatus;
    selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          _buildHandleBar(colorScheme),
          // Header
          ReportsFilterSheetHeader(
            onClearFilters: _clearFilters,
            hasFilters: _hasFilters(),
          ),
          verticalSpace(24),
          // Filter sections
          ReportsFilterSheetStatusSection(
            selectedStatus: selectedStatus,
            onToggleStatus: _toggleStatus,
          ),
          verticalSpace(24),
          ReportsFilterSheetCategoriesSection(
            selectedCategory: selectedCategory,
            onToggleCategory: _toggleCategory,
          ),
          ReportsFilterSheetActionButton(
            onPressed: _applyFilters,
            hasFilters: _hasFilters(),
            filterCount: _filterCount(),
          ),
          verticalSpace(16),
        ],
      ),
    );
  }

  Widget _buildHandleBar(ColorScheme colorScheme) {
    return Center(
      child: Container(
        width: 32.w,
        height: 4.h,
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      selectedStatus = null;
      selectedCategory = null;
    });
  }

  bool _hasFilters() {
    return selectedStatus != null || selectedCategory != null;
  }

  int _filterCount() {
    int count = 0;
    if (selectedStatus != null) count++;
    if (selectedCategory != null) count++;
    return count;
  }

  void _toggleStatus(ReportStatus? status, bool selected) {
    setState(() {
      selectedStatus = selected ? status : null;
    });
  }

  void _toggleCategory(IssueCategory? category, bool selected) {
    setState(() {
      selectedCategory = selected ? category : null;
    });
  }

  void _applyFilters() {
    widget.onApply(selectedStatus, selectedCategory);
    Navigator.pop(context);
  }
}
