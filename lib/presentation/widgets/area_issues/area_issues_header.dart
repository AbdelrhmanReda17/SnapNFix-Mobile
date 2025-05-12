import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/presentation/cubits/area_issues_cubit.dart';
import 'package:snapnfix/presentation/cubits/area_issues_state.dart';
import 'package:snapnfix/presentation/widgets/area_issues/filters/status_filter_button.dart';

class AreaIssuesHeader extends StatelessWidget {
  const AreaIssuesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<AreaIssuesCubit, AreaIssuesState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (issues, areaName, isSubscribed, selectedStatuses) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: colorScheme.outline.withOpacity(0.1)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Updates',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                  Row(
                    children: [
                      // Subscribe button
                      IconButton(
                        icon: Icon(
                          isSubscribed ? Icons.notifications_active : Icons.notifications_none,
                          color: colorScheme.primary,
                          size: 22.sp,
                        ),
                        onPressed: () => context.read<AreaIssuesCubit>().toggleSubscription(),
                        tooltip: isSubscribed ? 'Unsubscribe' : 'Subscribe',
                      ),

                      // Filter button
                      StatusFilterButton(selectedStatuses: selectedStatuses),
                    ],
                  ),
                ],
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}