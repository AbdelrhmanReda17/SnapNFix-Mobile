import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';

import 'package:snapnfix/modules/issues/presentation/widgets/issue_card/issue_card.dart';

class NearbyIssuesSection extends StatelessWidget {
  final List<Issue> issues;
  final Function(Issue)? onIssueSelected;
  final Function(Issue)? onReportFast;

  const NearbyIssuesSection({
    super.key,
    required this.issues,
    this.onIssueSelected,
    this.onReportFast,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: issues.length == 1 ? 0.2 : 0.3,
      minChildSize: issues.length == 1 ? 0.2 : 0.3,
      maxChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.surface.withValues(alpha: 0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildDragHandle(),
              _buildHeader(context),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  itemCount: issues.length,
                  itemBuilder:
                      (context, index) =>
                          _buildIssueCard(context, issues[index]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _buildFilterChip(context, 'All', true),
          SizedBox(width: 8.w),
          _buildFilterChip(context, 'Road Damage', false),
          SizedBox(width: 8.w),
          _buildFilterChip(context, 'Not Fixed', false),
          SizedBox(width: 8.w),
          _buildFilterChip(context, 'Most Reported', false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, bool isSelected) {
    final theme = Theme.of(context);
    return FilterChip(
      selected: isSelected,
      label: Text(label),
      onSelected: (_) {},
      backgroundColor:
          isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
      labelStyle: TextStyle(
        color:
            isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(
          color: isSelected ? Colors.transparent : theme.colorScheme.outline,
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        width: 40.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.place, color: theme.colorScheme.primary),
              SizedBox(width: 8.w),
              Text(
                'Nearby Issues',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  '${issues.length} found',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildIssueCard(BuildContext context, Issue issue) {
    return IssueCard(
      issue: issue,
      onTap: () => onIssueSelected?.call(issue),
      showReportButton: false,
    );
  }
}
