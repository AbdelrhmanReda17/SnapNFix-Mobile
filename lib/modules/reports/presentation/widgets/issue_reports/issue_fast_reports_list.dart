import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_paginated_list_view.dart';
import 'package:snapnfix/modules/reports/data/models/fast_report_model.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/issue_fast_reports_cubit.dart';

class IssueFastReportsList extends StatelessWidget {
  final String issueId;

  const IssueFastReportsList({super.key, required this.issueId});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return BlocBuilder<IssueFastReportsCubit, IssueFastReportsState>(
      builder: (context, state) {
        return EnhancedPaginatedView<FastReportModel>(
          items: state.reports,
          isLoading: state.isLoading,
          isLoadingMore: state.isLoadingMore,
          hasReachedEnd: state.hasReachedEnd,
          error: state.error,
          itemBuilder: (context, report, index) {
            return _buildFastReportCard(context, report);
          },
          onRefresh: () async {
            await context.read<IssueFastReportsCubit>().refreshReports(issueId);
          },
          onLoadMore: () {
            context.read<IssueFastReportsCubit>().loadReports(issueId: issueId);
          },
          separator: SizedBox(height: 12.h),
          padding: EdgeInsets.all(16.r),
          emptyStateBuilder:
              (context) => _buildEmptyState(context, localization),
          errorStateBuilder:
              (context, error) =>
                  _buildErrorState(context, error, localization),
        );
      },
    );
  }

  Widget _buildFastReportCard(BuildContext context, FastReportModel report) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: colorScheme.primary.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    color: colorScheme.primary,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${report.firstName ?? 'Anonymous'} ${report.lastName ?? ''}',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (report.createdAt != null)
                        Text(
                          _formatDate(report.createdAt!),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                    ],
                  ),
                ),
                if (report.severity != null)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: report.severity!.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: report.severity!.color.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      report.severity!.displayName,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: report.severity!.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(report.comment, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations localization) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.comment_outlined,
            size: 48.sp,
            color: theme.colorScheme.outline,
          ),
          SizedBox(height: 16.h),
          Text(
            'No fast reports yet',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Be the first to add a quick report',
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
                context.read<IssueFastReportsCubit>().refreshReports(issueId);
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
