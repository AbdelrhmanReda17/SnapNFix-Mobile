import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/report_review_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_card/report_card.dart';

class ReportsListView extends StatelessWidget {
  final ReportReviewState state;

  const ReportsListView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.reports.isEmpty) {
      return _buildEmptyReportsList(context);
    }

    return RefreshIndicator(
      onRefresh: () async {
        if (context.mounted) {
          await context.read<ReportReviewCubit>().refreshReports();
        }
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          // Detect when user has scrolled to the bottom of the list
          if (!state.isLoadingMore &&
              !state.hasReachedEnd &&
              scrollInfo.metrics.pixels > 0 &&
              scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 200) {
            if (context.mounted) {
              debugPrint('📜 Loading more reports from scroll');
              context.read<ReportReviewCubit>().loadReports();
            }
            return true;
          }
          return false;
        },
        child: ListView.builder(
          padding: EdgeInsets.all(16.r),
          // Add extra item if we're loading more
          itemCount: state.reports.length + (state.isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            // Show loading indicator at the end when loading more
            if (index == state.reports.length) {
              return _buildPaginationLoader();
            }

            final report = state.reports[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 16.r),
              child: ReportCard(report: report),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPaginationLoader() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildEmptyReportsList(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localization = AppLocalizations.of(context)!;

    // Check if filters are active
    final hasActiveFilters =
        state.currentStatus != null || state.currentCategory != null;

    return RefreshIndicator(
      onRefresh: () async {
        if (context.mounted) {
          await context.read<ReportReviewCubit>().refreshReports();
        }
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 0.7.sh,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    // Show different icon if filters are active
                    hasActiveFilters
                        ? Icons.filter_list
                        : Icons.list_alt_outlined,
                    size: 48.sp,
                    color: theme.colorScheme.outline,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    // Show different message based on filter state
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
                          context.read<ReportReviewCubit>().clearFilters();
                        },
                        icon: Icon(Icons.clear, size: 16.sp),
                        label: Text(localization.clearFilters),
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
