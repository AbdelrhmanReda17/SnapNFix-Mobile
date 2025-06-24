import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_state.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/area_subscription_header.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/subscribed_areas_list_widget.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/area_updates_loading_widget.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/area_updates_empty_state_widget.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/area_updates_error_widget.dart';

class AreaUpdatesSection extends StatelessWidget {
  const AreaUpdatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AreaSubscriptionCubit>()..initialize(),
      child: const AreaUpdatesSectionContent(),
    );
  }
}

class AreaUpdatesSectionContent extends StatelessWidget {
  const AreaUpdatesSectionContent({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          AreaSubscriptionHeader(
            colorScheme: colorScheme,
            onAdd: () {
              // TODO: Navigate to manage areas screen
            },
          ),
          SizedBox(height: 12.h),

          // Content based on subscription state
          BlocBuilder<AreaSubscriptionCubit, AreaSubscriptionState>(
            builder: (context, state) {
              return state.when(
                initial: () => const AreaUpdatesLoadingWidget(),
                loading: () => const AreaUpdatesLoadingWidget(),
                loaded: (subscribedAreas, isRefreshing) {
                  if (subscribedAreas.isEmpty) {
                    return AreaUpdatesEmptyStateWidget(colorScheme: colorScheme);
                  }
                  return SubscribedAreasListWidget(
                    subscribedAreas: subscribedAreas,
                    isRefreshing: isRefreshing,
                    colorScheme: colorScheme,
                    onSeeAll: () {
                      // TODO: Navigate to see all areas screen
                    },
                  );
                },
                error: (error, cachedAreas) {
                  if (cachedAreas.isEmpty) {
                    return AreaUpdatesErrorWidget(
                      message: error.message,
                      colorScheme: colorScheme,
                      onRetry: () {
                        context.read<AreaSubscriptionCubit>().refresh();
                      },
                    );
                  }
                  return SubscribedAreasListWidget(
                    subscribedAreas: cachedAreas,
                    isRefreshing: false,
                    colorScheme: colorScheme,
                    hasError: true,
                    onSeeAll: () {
                      // TODO: Navigate to see all areas screen
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
