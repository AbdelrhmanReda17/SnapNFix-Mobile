import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_paginated_list_view.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/all_areas_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/area_card.dart';

class AllAreasList extends StatelessWidget {
  final Function(AreaInfo)? onAreaTap;
  final EdgeInsetsGeometry? padding;
  final Widget? emptyWidget;
  final String? emptyMessage;

  const AllAreasList({
    super.key,
    this.onAreaTap,
    this.padding,
    this.emptyWidget,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AllAreasCubit, AllAreasState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (areas, hasReachedEnd, isLoadingMore, subscribingAreaIds, lastFetchTime, operationError) {
            if (operationError != null) {
              // Clear any existing snackbars first
              ScaffoldMessenger.of(context).clearSnackBars();
              
              final snackBar = SnackBar(
                content: Text(operationError),
                backgroundColor: Theme.of(context).colorScheme.error,
                duration: const Duration(seconds: 4),
                action: SnackBarAction(
                  label: 'Dismiss',
                  textColor: Colors.white,
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    context.read<AllAreasCubit>().clearOperationError();
                  },
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((_) {
                if (context.mounted) {
                  context.read<AllAreasCubit>().clearOperationError();
                }
              });
            }
          },
          orElse: () {},
        );
      },
      child: BlocBuilder<AllAreasCubit, AllAreasState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (areas, hasReachedEnd, isLoadingMore, subscribingAreaIds, lastFetchTime, operationError) {
            return EnhancedPaginatedView<AreaInfo>(
              items: areas,
              isLoading: false,
              isLoadingMore: isLoadingMore,
              hasReachedEnd: hasReachedEnd,
              itemBuilder: (context, area, index) {
                final isSubscribing = subscribingAreaIds.contains(area.id);
                return AreaCard(
                  area: area,
                  isSubscribed: false, // All areas in this list are unsubscribed
                  showSubscriptionButton: true,
                  isLoading: isSubscribing,
                  onSubscriptionToggle: isSubscribing ? null : () {
                    context.read<AllAreasCubit>().subscribeToArea(area.id);
                  },
                  onTap: onAreaTap != null ? () => onAreaTap!(area) : null,
                );
              },
              onRefresh: () async {
                if (context.mounted) {
                  await context.read<AllAreasCubit>().refresh();
                }
              },
              onLoadMore: () {
                context.read<AllAreasCubit>().loadMore();
              },
              padding: padding ?? EdgeInsets.symmetric(vertical: 8.h),
              emptyStateBuilder: (context) => _buildEmptyState(context),
              separator: SizedBox(height: 4.h),
            );
          },
          error: (error) => _buildErrorState(context, error.message),
        );
      },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    if (emptyWidget != null) {
      return emptyWidget!;
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Icon(
              Icons.location_city_outlined,
              size: 64.sp,
              color: Theme.of(context).colorScheme.outline,
            ),
            SizedBox(height: 16.h),
            Text(
              emptyMessage ?? 'No areas available',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'No new areas to subscribe to',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String errorMessage) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: 16.h),
            Text(
              'Failed to load areas',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              errorMessage,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            FilledButton(
              onPressed: () {
                context.read<AllAreasCubit>().refresh();
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
} 