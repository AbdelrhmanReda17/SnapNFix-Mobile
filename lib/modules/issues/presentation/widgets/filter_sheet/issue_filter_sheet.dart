import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';

import 'package:snapnfix/modules/issues/presentation/cubits/issues_map_cubit.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/filter_sheet/issue_filter_sheet_action_button.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/filter_sheet/issue_filter_sheet_categories_section.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/filter_sheet/issue_filter_sheet_severities_section.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/filter_sheet/issue_filter_sheet_header.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/filter_sheet/issue_filter_sheet_status_section.dart';

class IssueFilterSheet extends StatefulWidget {
  final List<IssueCategory> selectedCategories;
  final List<IssueSeverity> selectedSeverities;
  final List<IssueStatus> selectedStatuses;
  final Function(List<IssueCategory>, List<IssueSeverity>, List<IssueStatus>)
  onApply;

  const IssueFilterSheet({
    super.key,
    required this.selectedCategories,
    required this.selectedSeverities,
    required this.selectedStatuses,
    required this.onApply,
  });

  static Future<void> show(BuildContext context) {
    final mapCubit = context.read<IssuesMapCubit>();
    final state = mapCubit.state;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => IssueFilterSheet(
            selectedCategories: state.selectedCategories,
            selectedSeverities: state.selectedSeverities,
            selectedStatuses: state.selectedStatuses,
            onApply: (categories, severities, statuses) {
              mapCubit.applyFilters(
                selectedCategories: categories,
                selectedSeverities: severities,
                selectedStatuses: statuses,
              );
            },
          ),
    );
  }

  @override
  State<IssueFilterSheet> createState() => _IssueFilterSheetState();
}

class _IssueFilterSheetState extends State<IssueFilterSheet> {
  late List<IssueCategory> selectedCategories;
  late List<IssueSeverity> selectedSeverities;
  late List<IssueStatus> selectedStatuses;

  @override
  void initState() {
    super.initState();
    selectedCategories = List.from(widget.selectedCategories);
    selectedSeverities = List.from(widget.selectedSeverities);
    selectedStatuses = List.from(widget.selectedStatuses);
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
          IssueFilterSheetHeader(
            onClearFilters: _clearFilters,
            hasFilters: _hasFilters(),
          ),
          SizedBox(height: 24.h),
          // Filter sections
          IssueFilterSheetCategoriesSection(
            selectedCategories: selectedCategories,
            onToggleCategory: _toggleCategory,
          ),
          SizedBox(height: 24.h),
          IssueFilterSheetSeveritiesSection(
            selectedSeverities: selectedSeverities,
            onToggleSeverity: _toggleSeverity,
          ),
          SizedBox(height: 24.h),
          IssueFilterSheetStatusSection(
            selectedStatuses: selectedStatuses,
            onToggleStatus: _toggleStatus,
          ),
          IssueFilterSheetActionButton(
            onPressed: _applyFilters,
            hasFilters: _hasFilters(),
            filterCount: _filterCount(),
          ),
          SizedBox(height: 16.h),
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
      selectedCategories.clear();
      selectedSeverities.clear();
      selectedStatuses.clear();
    });
  }

  bool _hasFilters() {
    return selectedCategories.isNotEmpty ||
        selectedSeverities.isNotEmpty ||
        selectedStatuses.isNotEmpty;
  }

  int _filterCount() {
    return selectedCategories.length +
        selectedSeverities.length +
        selectedStatuses.length;
  }

  void _toggleCategory(IssueCategory category, bool selected) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
    });
  }

  void _toggleSeverity(IssueSeverity severity, bool selected) {
    setState(() {
      if (selectedSeverities.contains(severity)) {
        selectedSeverities.remove(severity);
      } else {
        selectedSeverities.add(severity);
      }
    });
  }

  void _toggleStatus(IssueStatus status, bool selected) {
    setState(() {
      if (selectedStatuses.contains(status)) {
        selectedStatuses.remove(status);
      } else {
        selectedStatuses.add(status);
      }
    });
  }

  void _applyFilters() {
    widget.onApply(selectedCategories, selectedSeverities, selectedStatuses);
    Navigator.pop(context);
  }
}
