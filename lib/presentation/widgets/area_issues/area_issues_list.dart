import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/presentation/cubits/area_issues_cubit.dart';
import 'package:snapnfix/presentation/cubits/area_issues_state.dart';
import 'package:snapnfix/presentation/widgets/area_issues/empty_issues_view.dart';
import 'package:snapnfix/presentation/widgets/area_issues/issues_refresh_indicator.dart';

class AreaIssuesList extends StatelessWidget {
  const AreaIssuesList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<AreaIssuesCubit, AreaIssuesState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => Center(
            child: CircularProgressIndicator(color: colorScheme.primary),
          ),
          error: (error) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: colorScheme.error, size: 48.sp),
                SizedBox(height: 16.h),
                Text(
                  error,
                  style: TextStyle(
                    color: colorScheme.error,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () {
                    final cubit = context.read<AreaIssuesCubit>();
                    cubit.state.maybeWhen(
                      loaded: (issues, areaName, isSubscribed, selectedStatuses) {
                        cubit.loadAreaIssues(areaName);
                      },
                      orElse: () {},
                    );
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          loaded: (issues, areaName, isSubscribed, selectedStatuses) {
            final filteredIssues = context.read<AreaIssuesCubit>().getFilteredIssues();
            if (filteredIssues.isEmpty) {
              return EmptyIssuesView(
                areaName: areaName,
                selectedStatuses: selectedStatuses,
              );
            }
            return IssuesRefreshIndicator(
              issues: filteredIssues,
              areaName: areaName,
            );
          },
        );
      },
    );
  }
}