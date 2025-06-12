import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/user_reports_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_filters/reports_sort_menu.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/reports_error_view_widget.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/reports_list.dart';
import 'package:snapnfix/presentation/widgets/loading_overlay.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_filters/reports_filter_sheet.dart';

class UserReportsScreen extends StatefulWidget {
  const UserReportsScreen({super.key});

  @override
  State<UserReportsScreen> createState() => _UserReportsScreenState();
}

class _UserReportsScreenState extends State<UserReportsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<UserReportsCubit>().loadReports();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localization = AppLocalizations.of(context)!;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: colorScheme.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        titleSpacing: 0,
        centerTitle: true,
        elevation: 0,
        title: Text(
          localization.myReports,
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: colorScheme.primary,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildFilterToolbar(context),

          Expanded(
            child: BlocBuilder<UserReportsCubit, UserReportsState>(
              buildWhen: (previous, current) {
                final changed =
                    previous.isLoading != current.isLoading ||
                    previous.reports != current.reports ||
                    previous.error != current.error ||
                    previous.isLoadingMore != current.isLoadingMore;
                return changed;
              },
              builder: (context, state) {
                if (state.isLoading && state.reports.isEmpty) {
                  return const LoadingOverlay();
                }
                if (state.error != null && state.reports.isEmpty) {
                  return ReportsErrorView(errorMessage: state.error!);
                }
                return ReportsListView(state: state);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context, UserReportsState state) {
    ReportsFilterSheet.show(context);
  }

  Widget _buildFilterToolbar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localization = AppLocalizations.of(context)!;

    return BlocBuilder<UserReportsCubit, UserReportsState>(
      buildWhen:
          (previous, current) =>
              previous.currentStatus != current.currentStatus ||
              previous.currentCategory != current.currentCategory ||
              previous.currentSortOption != current.currentSortOption,
      builder: (context, state) {
        final hasActiveFilters =
            state.currentStatus != null || state.currentCategory != null;

        // Count active filters
        int filterCount = 0;
        if (state.currentStatus != null) filterCount++;
        if (state.currentCategory != null) filterCount++;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 1.r,
                spreadRadius: 1.r,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _showFilterBottomSheet(context, state),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          hasActiveFilters
                              ? colorScheme.primary.withValues(alpha: 0.15)
                              : colorScheme.surface,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color:
                            hasActiveFilters
                                ? colorScheme.primary
                                : colorScheme.outline.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_list,
                          size: 20.sp,
                          color:
                              hasActiveFilters
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          hasActiveFilters
                              ? localization.nFiltersApplied(filterCount)
                              : localization.filter,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight:
                                hasActiveFilters
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                            color:
                                hasActiveFilters
                                    ? colorScheme.primary
                                    : colorScheme.onSurfaceVariant,
                          ),
                        ),
                        if (hasActiveFilters) ...[
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              filterCount.toString(),
                              style: TextStyle(
                                color: colorScheme.onPrimary,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              // Sort dropdown
              ReportsSortMenu(currentSortOption: state.currentSortOption),
            ],
          ),
        );
      },
    );
  }
}
