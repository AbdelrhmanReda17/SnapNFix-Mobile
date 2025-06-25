import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/presentation/cubits/area_issues_cubit.dart';
import 'package:snapnfix/presentation/widgets/area_issues/issue_item.dart';

class IssuesRefreshIndicator extends StatelessWidget {
  final List<Issue> issues;
  final String areaName;

  const IssuesRefreshIndicator({
    super.key,
    required this.issues,
    required this.areaName,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return RefreshIndicator(
      color: colorScheme.primary,
      onRefresh: () => context.read<AreaIssuesCubit>().loadAreaIssues(areaName),
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: 16.h),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: issues.length,
        separatorBuilder:
            (context, index) => Divider(
              height: 1.h,
              indent: 60.w,
              endIndent: 16.w,
              color: colorScheme.outline.withValues(alpha: 0.1),
            ),
        itemBuilder: (context, index) {
          final issue = issues[index];
          return IssueItem(
            issue: issue,
            onTap:
                () => context.read<AreaIssuesCubit>().navigateToIssueDetails(
                  context,
                  issue.id,
                ),
          );
        },
      ),
    );
  }
}
