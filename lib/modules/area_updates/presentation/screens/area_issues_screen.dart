import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/base_components/base_paginated_list_view.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_details.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_health_metrics.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_issue.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_all_area_details.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/toggle_area_subscription_use_case.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_details/area_details_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_notifier.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/area_issue_card.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class AreaIssuesScreen extends StatefulWidget {
  final AreaInfo areaInfo;
  final bool isSubscribed;

  const AreaIssuesScreen({
    required this.areaInfo,
    bool? isSubscribed,
    super.key,
  }) : isSubscribed = isSubscribed ?? false;

  @override
  State<AreaIssuesScreen> createState() => _AreaIssuesScreenState();
}

class _AreaIssuesScreenState extends State<AreaIssuesScreen> {
  late AreaDetailsCubit _cubit;
  final int _pageLimit = 3;

  @override
  void initState() {
    super.initState();
    _cubit = AreaDetailsCubit(
      getAreaDetailsUseCase: getIt<GetAreaDetailsUseCase>(),
      toggleAreaSubscriptionUseCase: getIt<ToggleAreaSubscriptionUseCase>(),
      subscriptionNotifier: AreaSubscriptionNotifier(),
    );
    _loadAreaDetails();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _loadAreaDetails() {
    _cubit.loadAreaDetails(
      areaInfo: widget.areaInfo,
      isSubscribed: widget.isSubscribed,
      page: 1,
      limit: _pageLimit,
    );
  }

  void _refreshAreaDetails() {
    _cubit.refreshAreaDetails(
      areaInfo: widget.areaInfo,
      isSubscribed: widget.isSubscribed,
      limit: _pageLimit,
    );
  }

  void _loadMoreIssues() {
    _cubit.loadMoreIssues(
      areaInfo: widget.areaInfo,
      isSubscribed: widget.isSubscribed,
      limit: _pageLimit,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.home_work, color: colorScheme.primary, size: 24.sp),
              SizedBox(width: 12.w),
              Text(
                '${widget.areaInfo.name} Issues',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          actions: [
            BlocBuilder<AreaDetailsCubit, AreaDetailsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loaded: (areaDetails, isSubscriptionLoading) {
                    if (isSubscriptionLoading) {
                      return Padding(
                        padding: EdgeInsets.all(12.w),
                        child: SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.w,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colorScheme.primary,
                            ),
                          ),
                        ),
                      );
                    }

                    return IconButton(
                      icon: Icon(
                        areaDetails.isSubscribed
                            ? Icons.notifications_active
                            : Icons.notifications_none,
                        color:
                            areaDetails.isSubscribed
                                ? colorScheme.primary
                                : colorScheme.onSurface,
                      ),
                      onPressed:
                          () => _toggleSubscription(areaDetails.isSubscribed),
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _refreshAreaDetails();
          },
          child: BlocBuilder<AreaDetailsCubit, AreaDetailsState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(child: CircularProgressIndicator()),
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded:
                    (areaDetails, isSubscriptionLoading) =>
                        _buildLoadedContent(context, areaDetails, localization),
                error:
                    (error) => _buildErrorState(context, error, localization),
              );
            },
          ),
        ),
      ),
    );
  }

  void _toggleSubscription(bool isCurrentlySubscribed) async {
    final result = await _cubit.toggleSubscription(
      areaInfo: widget.areaInfo,
      currentSubscriptionStatus: isCurrentlySubscribed,
    );

    result.when(
      success: (newSubscriptionStatus) {
        final message =
            newSubscriptionStatus
                ? 'Successfully subscribed to ${widget.areaInfo.name}'
                : 'Successfully unsubscribed from ${widget.areaInfo.name}';
        _showSuccessSnackBar(message);
      },
      failure: (error) => _showErrorSnackBar(error),
    );
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showSuccessSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildLoadedContent(
    BuildContext context,
    AreaDetails areaDetails,
    AppLocalizations localization,
  ) {
    return Column(
      children: [
        _buildAreaHealthCard(context, localization, areaDetails.healthMetrics),
        Expanded(
          child: _buildIssuesList(context, areaDetails.issues, localization),
        ),
      ],
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    error,
    AppLocalizations localization,
  ) {
    return Center(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Icon(
            Icons.error_outline,
            size: 48.sp,
            color: Theme.of(context).colorScheme.error,
          ),
          SizedBox(height: 16.h),
          Text(
            error.message ?? 'An error occurred',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: _refreshAreaDetails,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildIssuesList(
    BuildContext context,
    List<AreaIssue> issues,
    AppLocalizations localization,
  ) {
    return BlocBuilder<AreaDetailsCubit, AreaDetailsState>(
      builder: (context, state) {
        return EnhancedPaginatedView(
          items: issues,
          isLoading: false,
          isLoadingMore: _cubit.isLoadingMore,
          hasReachedEnd: !_cubit.hasMoreData,
          enableRefresh: false,
          itemBuilder:
              (context, issue, index) => AreaIssueCard(
                issue: issue,
                margin: EdgeInsets.only(bottom: 12.h),
                onTap: () {
                  context.push(Routes.issueDetails, extra: issue.id);
                },
              ),
          onRefresh: () async => {},
          onLoadMore:
              _cubit.hasMoreData
                  ? _loadMoreIssues
                  : () {
                    debugPrint('No more issues to load');
                  },
          emptyStateBuilder:
              (context) => _buildEmptyIssuesState(context, localization),
          separator: SizedBox(height: 12.h),
          padding: EdgeInsets.all(16.w),
        );
      },
    );
  }

  Widget _buildEmptyIssuesState(
    BuildContext context,
    AppLocalizations localization,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        Icon(Icons.task_alt_outlined, size: 64.sp, color: colorScheme.outline),
        SizedBox(height: 16.h),
        Text(
          'No Issues Found',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'All issues in this area have been resolved!',
          style: TextStyle(
            fontSize: 14.sp,
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAreaHealthCard(
    BuildContext context,
    AppLocalizations localization,
    AreaHealthMetrics healthMetrics,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final healthScore = healthMetrics.healthPercentage;
    final healthColor = _getHealthColor(healthScore);

    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          // Health header with score
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: healthColor.withValues(alpha: 0.1),
                    border: Border.all(color: healthColor, width: 2.w),
                  ),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      '${(healthScore).toInt()}%',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: healthColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Area Health Status',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        healthMetrics.healthCondition.displayName,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: healthColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: colorScheme.outline.withValues(alpha: 0.1),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetricItem(
                  context,
                  Icons.error_outline,
                  '${healthMetrics.pendingIssuesCount}',
                  'Open Issues',
                  Colors.orange,
                ),
                _buildMetricItem(
                  context,
                  Icons.check_circle_outline,
                  '${healthMetrics.inProgressIssuesCount}',
                  'In Progress Issues',
                  Colors.green,
                ),
                _buildMetricItem(
                  context,
                  Icons.timer_outlined,
                  '${healthMetrics.fixedIssuesCount}',
                  'Closed Issues',
                  Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Icon(icon, color: color, size: 24.sp),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Color _getHealthColor(double healthPercentage) {
    if (healthPercentage >= 75) {
      return Colors.green;
    } else if (healthPercentage >= 50) {
      return Colors.yellow;
    } else if (healthPercentage >= 25) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
