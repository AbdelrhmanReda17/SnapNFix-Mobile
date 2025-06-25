import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_paginated_list_view.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/paginated_areas_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/area_card.dart';

class PaginatedAreasList extends StatelessWidget {
  final bool showSubscriptionButtons;
  final Function(AreaInfo)? onAreaTap;
  final EdgeInsetsGeometry? padding;
  final Widget? emptyWidget;
  final String? emptyMessage;

  const PaginatedAreasList({
    super.key,
    this.showSubscriptionButtons = true,
    this.onAreaTap,
    this.padding,
    this.emptyWidget,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginatedAreasCubit, PaginatedAreasState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (areas, hasReachedEnd, isLoadingMore, subscribedAreaNames) {
            return EnhancedPaginatedView<AreaInfo>(
              items: areas,
              isLoading: false,
              isLoadingMore: isLoadingMore,
              hasReachedEnd: hasReachedEnd,
              itemBuilder: (context, area, index) {
                return AreaCard(
                  area: area,
                  isSubscribed: subscribedAreaNames.contains(area.name),
                  showSubscriptionButton: showSubscriptionButtons,
                  onSubscriptionToggle: () {
                    final cubit = context.read<PaginatedAreasCubit>();
                    if (cubit.isSubscribedToArea(area.id)) {
                      cubit.unsubscribeFromArea(area.id);
                    } else {
                      cubit.subscribeToArea(area.id);
                    }
                  },
                  onTap: onAreaTap != null ? () => onAreaTap!(area) : null,
                );
              },
              onRefresh: () async {
                await context.read<PaginatedAreasCubit>().refresh();
              },
              onLoadMore: () {
                context.read<PaginatedAreasCubit>().loadMore();
              },
              padding: padding ?? EdgeInsets.symmetric(vertical: 8.h),
              emptyStateBuilder: (context) => _buildEmptyState(context),
              separator: SizedBox(height: 4.h),
            );
          },
          error: (error) => _buildErrorState(context, error.message),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    if (emptyWidget != null) {
      return emptyWidget!;
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_city_outlined,
              size: 64.sp,
              color: Theme.of(context).colorScheme.outline,
            ),
            SizedBox(height: 16.h),
            Text(
              emptyMessage ?? 'No areas found',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'Pull to refresh or try adjusting your search',
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
                context.read<PaginatedAreasCubit>().refresh();
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
