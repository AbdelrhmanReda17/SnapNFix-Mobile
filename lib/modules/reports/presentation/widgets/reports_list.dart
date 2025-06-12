import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_paginated_list_view.dart';
import 'package:snapnfix/modules/reports/data/models/report_model.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/user_reports_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_card/report_card.dart';

class ReportsListView extends StatelessWidget {
  final UserReportsState state;

  const ReportsListView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return EnhancedPaginatedView<ReportModel>(
      items: state.reports,
      isLoading: state.isLoading,
      isLoadingMore: state.isLoadingMore,
      hasReachedEnd: state.hasReachedEnd,
      error: state.error,
      itemBuilder: (context, report, index) {
        return ReportCard(report: report);
      },
      onRefresh: () async {
        if (context.mounted) {
          await context.read<UserReportsCubit>().loadReports(refresh: true);
        }
      },
      onLoadMore: () {
        if (context.mounted) {
          debugPrint('📜 Loading more reports from enhanced paginated view');
          context.read<UserReportsCubit>().loadReports();
        }
      },
      separator: SizedBox(height: 16.h),
      padding: EdgeInsets.all(16.r),
      emptyStateBuilder:
          (context) => _buildEmptyReportsList(context, localization),
      errorStateBuilder:
          (context, error) => _buildErrorState(context, error, localization),
      loadingStateBuilder: (context) => _buildLoadingState(context),
      paginationLoadingBuilder: (context) => _buildPaginationLoader(),
    );
  }

  Widget _buildEmptyReportsList(
    BuildContext context,
    AppLocalizations localization,
  ) {
    final theme = Theme.of(context);

    // Check if filters are active
    final hasActiveFilters =
        state.currentStatus != null || state.currentCategory != null;

    return SizedBox(
      height: 0.7.sh,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasActiveFilters ? Icons.filter_list : Icons.list_alt_outlined,
              size: 48.sp,
              color: theme.colorScheme.outline,
            ),
            SizedBox(height: 16.h),
            Text(
              hasActiveFilters
                  ? localization.noReportsForFilters
                  : localization.noReports,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            // Add clear filters button when filters are active
            if (hasActiveFilters)
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: TextButton.icon(
                  onPressed: () {
                    context.read<UserReportsCubit>().clearFilters();
                  },
                  icon: Icon(Icons.clear, size: 16.sp),
                  label: Text(localization.clearFilters),
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.primary,
                  ),
                ),
              ),
          ],
        ),
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
                debugPrint('🔄 Retrying reports load from error view');
                context.read<UserReportsCubit>().loadReports(refresh: true);
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

  Widget _buildLoadingState(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildPaginationLoader() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
