import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_paginated_list_view.dart';
import 'package:snapnfix/modules/reports/data/models/snap_report_model.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/issue_snap_reports_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_card/report_card.dart';

class IssueSnapReportsList extends StatelessWidget {
  final String issueId;

  const IssueSnapReportsList({
    super.key,
    required this.issueId,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    
    return BlocBuilder<IssueSnapReportsCubit, IssueSnapReportsState>(
      builder: (context, state) {
        return EnhancedPaginatedView<SnapReportModel>(
          items: state.reports,
          isLoading: state.isLoading,
          isLoadingMore: state.isLoadingMore,
          hasReachedEnd: state.hasReachedEnd,
          error: state.error,
          itemBuilder: (context, report, index) {
            return ReportCard(report: report);
          },
          onRefresh: () async {
            await context
                .read<IssueSnapReportsCubit>()
                .refreshReports(issueId);
          },
          onLoadMore: () {
            context
                .read<IssueSnapReportsCubit>()
                .loadReports(issueId: issueId);
          },
          separator: SizedBox(height: 16.h),
          padding: EdgeInsets.all(16.r),
          emptyStateBuilder: (context) => _buildEmptyState(context, localization),
          errorStateBuilder: (context, error) => _buildErrorState(context, error, localization),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations localization) {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_camera_outlined,
            size: 48.sp,
            color: theme.colorScheme.outline,
          ),
          SizedBox(height: 16.h),
          Text(
            'No snap reports yet',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Be the first to snap and report',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    String error,
    AppLocalizations localization,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: colorScheme.error),
            SizedBox(height: 16.h),
            Text(
              error,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                context
                    .read<IssueSnapReportsCubit>()
                    .refreshReports(issueId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
              ),
              child: Text(localization.tryAgain),
            ),
          ],
        ),
      ),
    );
  }
}