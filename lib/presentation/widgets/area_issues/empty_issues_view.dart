import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';
import 'package:snapnfix/presentation/cubits/area_issues_cubit.dart';

class EmptyIssuesView extends StatelessWidget {
  final String areaName;
  final List<IssueStatus> selectedStatuses;
  
  const EmptyIssuesView({
    super.key,
    required this.areaName,
    required this.selectedStatuses,
  });  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            color: colorScheme.primary.withOpacity(0.5),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),          Text(
            selectedStatuses.isEmpty
                ? localization.noIssuesFoundIn(areaName)
                : localization.noReportsForFilters,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.center,
          ),
          if (selectedStatuses.isNotEmpty) ...[
            SizedBox(height: 16.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              ),
              onPressed: () => context.read<AreaIssuesCubit>().clearFilters(),
              child: Text(localization.clearFilters),
            ),
          ],
        ],
      ),
    );
  }
} 