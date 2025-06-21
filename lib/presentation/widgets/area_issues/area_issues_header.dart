import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/presentation/cubits/area_issues_cubit.dart';
import 'package:snapnfix/presentation/cubits/area_issues_state.dart';
import 'package:snapnfix/presentation/widgets/area_issues/filters/status_filter_button.dart';

class AreaIssuesHeader extends StatelessWidget {
  const AreaIssuesHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;
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
                children: [                  Text(
                    localization.updates,
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
                        tooltip: isSubscribed ? localization.unsubscribe : localization.subscribe,
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