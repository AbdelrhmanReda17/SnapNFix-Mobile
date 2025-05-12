import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';
import 'package:snapnfix/presentation/cubits/area_issues_cubit.dart';

class StatusFilterButton extends StatelessWidget {
  final List<IssueStatus> selectedStatuses;
  
  const StatusFilterButton({
    super.key,
    required this.selectedStatuses,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return PopupMenuButton<IssueStatus?>(
      icon: Icon(
        Icons.filter_list,
        color: selectedStatuses.isEmpty 
            ? colorScheme.primary 
            : colorScheme.primary.withOpacity(0.5),
        size: 22.sp,
      ),
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      tooltip: 'Filter by status',
      itemBuilder: (context) => [
        ...IssueStatus.values.map((status) => PopupMenuItem<IssueStatus>(
          value: status,
          height: 40.h,
          child: Row(
            children: [
              Icon(
                selectedStatuses.contains(status)
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
                color: status.color,
                size: 20.r,
              ),
              SizedBox(width: 8.w),
              Text(
                status.displayName,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        )),
        if (selectedStatuses.isNotEmpty) ...[
          PopupMenuItem(
            height: 32.h,
            enabled: false,
            padding: EdgeInsets.zero,
            child: const Divider(height: 1),
          ),
          PopupMenuItem<IssueStatus?>(
            onTap: () => context.read<AreaIssuesCubit>().clearFilters(),
            height: 40.h,
            value: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.clear_all,
                  color: colorScheme.error,
                  size: 18.r,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Clear Filters',
                  style: TextStyle(
                    color: colorScheme.error,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
      onSelected: (status) {
        if (status == null) {
          context.read<AreaIssuesCubit>().clearFilters();
        } else {
          context.read<AreaIssuesCubit>().toggleStatusFilter(status);
        }
      },
    );
  }
} 