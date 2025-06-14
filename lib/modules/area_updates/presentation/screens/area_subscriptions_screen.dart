import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/all_areas_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/all_areas_state.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_state.dart';

class AreaSubscriptionsScreen extends StatelessWidget {
  const AreaSubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  AreaSubscriptionCubit(getIt<BaseAreaUpdatesRepository>())
                    ..initialize(),
        ),
        BlocProvider(
          create:
              (context) =>
                  AllAreasCubit(getIt<BaseAreaUpdatesRepository>())
                    ..fetchAllAreas(),
        ),
      ],
      child: const AreaSubscriptionsView(),
    );
  }
}

class AreaSubscriptionsView extends StatelessWidget {
  const AreaSubscriptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Areas'),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        actions: [
          BlocBuilder<AreaSubscriptionCubit, AreaSubscriptionState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<AreaSubscriptionCubit>().refresh();
                  context.read<AllAreasCubit>().refreshAreas();
                },
                icon: const Icon(Icons.refresh),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            context.read<AreaSubscriptionCubit>().refresh(),
            context.read<AllAreasCubit>().refreshAreas(),
          ]);
        },
        child: CustomScrollView(
          slivers: [
            // Subscribed Areas Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<AreaSubscriptionCubit, AreaSubscriptionState>(
                      builder: (context, state) {
                        return state.when(
                          initial: () => const SizedBox.shrink(),
                          loading: () => const _SubscriptionLoadingWidget(),
                          loaded: (subscribedAreas, isRefreshing) {
                            if (subscribedAreas.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return _SubscribedAreasSection(
                              subscribedAreas: subscribedAreas,
                              colorScheme: colorScheme,
                            );
                          },
                          error: (message, cachedAreas) {
                            if (cachedAreas.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return _SubscribedAreasSection(
                              subscribedAreas: cachedAreas,
                              colorScheme: colorScheme,
                              hasError: true,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // All Areas Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Available Areas',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: BlocBuilder<AllAreasCubit, AllAreasState>(
                builder: (context, state) {
                  return state.when(
                    initial:
                        () =>
                            const SliverToBoxAdapter(child: SizedBox.shrink()),
                    loading:
                        () => const SliverToBoxAdapter(
                          child: _AreasLoadingWidget(),
                        ),
                    loaded:
                        (areas) => _AreasGridView(
                          areas: areas,
                          colorScheme: colorScheme,
                        ),
                    error:
                        (message) => SliverToBoxAdapter(
                          child: _ErrorWidget(
                            message: message,
                            colorScheme: colorScheme,
                            onRetry:
                                () =>
                                    context
                                        .read<AllAreasCubit>()
                                        .fetchAllAreas(),
                          ),
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Subscribed Areas Section Widget
class _SubscribedAreasSection extends StatelessWidget {
  final List<String> subscribedAreas;
  final ColorScheme colorScheme;
  final bool hasError;

  const _SubscribedAreasSection({
    required this.subscribedAreas,
    required this.colorScheme,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Your Subscriptions',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            if (hasError) ...[
              SizedBox(width: 8.w),
              Icon(
                Icons.warning_amber_rounded,
                size: 16.sp,
                color: colorScheme.error,
              ),
            ],
          ],
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children:
              subscribedAreas.map((area) {
                return _SubscribedAreaChip(
                  areaName: area,
                  colorScheme: colorScheme,
                  onUnsubscribe: () {
                    context.read<AreaSubscriptionCubit>().unsubscribeFromArea(
                      area,
                    );
                  },
                );
              }).toList(),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}

// Subscribed Area Chip Widget
class _SubscribedAreaChip extends StatelessWidget {
  final String areaName;
  final ColorScheme colorScheme;
  final VoidCallback onUnsubscribe;

  const _SubscribedAreaChip({
    required this.areaName,
    required this.colorScheme,
    required this.onUnsubscribe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, size: 16.sp, color: colorScheme.primary),
          SizedBox(width: 6.w),
          Text(
            areaName,
            style: TextStyle(
              fontSize: 14.sp,
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 6.w),
          GestureDetector(
            onTap: onUnsubscribe,
            child: Icon(
              Icons.close,
              size: 16.sp,
              color: colorScheme.onPrimaryContainer.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

// Areas Grid View
class _AreasGridView extends StatelessWidget {
  final List<dynamic> areas; // Replace with your AreaInfo model
  final ColorScheme colorScheme;

  const _AreasGridView({required this.areas, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.2,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final area = areas[index];
        return BlocBuilder<AreaSubscriptionCubit, AreaSubscriptionState>(
          builder: (context, subscriptionState) {
            final isSubscribed = context
                .read<AreaSubscriptionCubit>()
                .isSubscribedToArea(area.name); // Adjust based on your model

            return _AreaTile(
              area: area,
              isSubscribed: isSubscribed,
              colorScheme: colorScheme,
              onToggleSubscription: () {
                context.read<AreaSubscriptionCubit>().toggleAreaSubscription(
                  area.name,
                );
              },
            );
          },
        );
      }, childCount: areas.length),
    );
  }
}

// Individual Area Tile
class _AreaTile extends StatelessWidget {
  final dynamic area; // Replace with your AreaInfo model
  final bool isSubscribed;
  final ColorScheme colorScheme;
  final VoidCallback onToggleSubscription;

  const _AreaTile({
    required this.area,
    required this.isSubscribed,
    required this.colorScheme,
    required this.onToggleSubscription,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onToggleSubscription,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color:
                isSubscribed
                    ? colorScheme.primaryContainer.withOpacity(0.7)
                    : colorScheme.surfaceVariant.withOpacity(0.5),
            border: Border.all(
              color:
                  isSubscribed
                      ? colorScheme.primary
                      : colorScheme.outline.withOpacity(0.3),
              width: isSubscribed ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color:
                      isSubscribed ? colorScheme.primary : colorScheme.outline,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    area.name[0].toUpperCase(), // Adjust based on your model
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color:
                          isSubscribed
                              ? colorScheme.onPrimary
                              : colorScheme.surface,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                area.name, // Adjust based on your model
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color:
                      isSubscribed
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 4.h),
              Icon(
                isSubscribed ? Icons.check_circle : Icons.add_circle_outline,
                size: 20.sp,
                color:
                    isSubscribed
                        ? colorScheme.primary
                        : colorScheme.onSurface.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Loading Widgets
class _SubscriptionLoadingWidget extends StatelessWidget {
  const _SubscriptionLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _AreasLoadingWidget extends StatelessWidget {
  const _AreasLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

// Error Widget
class _ErrorWidget extends StatelessWidget {
  final String message;
  final ColorScheme colorScheme;
  final VoidCallback onRetry;

  const _ErrorWidget({
    required this.message,
    required this.colorScheme,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: colorScheme.errorContainer.withOpacity(0.3),
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: colorScheme.error),
          SizedBox(height: 12.h),
          Text(
            'Failed to Load Areas',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onErrorContainer,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: colorScheme.onErrorContainer.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
