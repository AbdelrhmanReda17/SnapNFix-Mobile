import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_all_areas_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_subscribed_areas_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/subscribe_to_area_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/unsubscribe_from_area_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/toggle_area_subscription_use_case.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/all_areas_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/all_areas_state.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_state.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/subscribed_areas_section.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/areas_grid_view.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/common_widgets.dart';

class AreaSubscriptionsScreen extends StatelessWidget {
  const AreaSubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AreaSubscriptionCubit(
            getSubscribedAreasUseCase: getIt<GetSubscribedAreasUseCase>(),
            subscribeToAreaUseCase: getIt<SubscribeToAreaUseCase>(),
            unsubscribeFromAreaUseCase: getIt<UnsubscribeFromAreaUseCase>(),
            toggleAreaSubscriptionUseCase: getIt<ToggleAreaSubscriptionUseCase>(),
          )..initialize(),
        ),
        BlocProvider(
          create: (context) => AllAreasCubit(
            getAllAreasUseCase: getIt<GetAllAreasUseCase>(),
          )..fetchAllAreas(),
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
                          loading: () => const SubscriptionLoadingWidget(),
                          loaded: (subscribedAreas, isRefreshing) {
                            if (subscribedAreas.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return SubscribedAreasSection(
                              subscribedAreas: subscribedAreas,
                              colorScheme: colorScheme,
                              onUnsubscribe: (areaName) {
                                context.read<AreaSubscriptionCubit>().unsubscribeFromArea(areaName);
                              },
                            );
                          },
                          error: (error, cachedAreas) {
                            if (cachedAreas.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return SubscribedAreasSection(
                              subscribedAreas: cachedAreas,
                              colorScheme: colorScheme,
                              hasError: true,
                              onUnsubscribe: (areaName) {
                                context.read<AreaSubscriptionCubit>().unsubscribeFromArea(areaName);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Available Areas Section Header
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

            // Available Areas Grid
            SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: BlocBuilder<AllAreasCubit, AllAreasState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
                    loading: () => const SliverToBoxAdapter(child: AreasLoadingWidget()),
                    loaded: (areas) => AreasGridView(
                      areas: areas,
                      colorScheme: colorScheme,
                      onToggleSubscription: (areaName) {
                        context.read<AreaSubscriptionCubit>().toggleAreaSubscription(areaName);
                      },
                    ),
                    error: (error) => SliverToBoxAdapter(
                      child: GeneralErrorWidget(
                        message: error.message,
                        colorScheme: colorScheme,
                        onRetry: () => context.read<AllAreasCubit>().fetchAllAreas(),
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
