import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_state.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Areas',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              BlocBuilder<AreaSubscriptionCubit, AreaSubscriptionState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context.read<AreaSubscriptionCubit>().refresh();
                    },
                    icon: Icon(
                      Icons.refresh,
                      size: 20.sp,
                      color: colorScheme.primary,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Content based on subscription state
          BlocBuilder<AreaSubscriptionCubit, AreaSubscriptionState>(
            builder: (context, state) {
              return state.when(
                initial: () => const _LoadingWidget(),
                loading: () => const _LoadingWidget(),
                loaded: (subscribedAreas, isRefreshing) {
                  if (subscribedAreas.isEmpty) {
                    return _EmptyStateWidget(colorScheme: colorScheme);
                  }
                  return _SubscribedAreasWidget(
                    subscribedAreas: subscribedAreas,
                    isRefreshing: isRefreshing,
                    colorScheme: colorScheme,
                  );
                },
                error: (message, cachedAreas) {
                  if (cachedAreas.isEmpty) {
                    return _ErrorWidget(
                      message: message,
                      colorScheme: colorScheme,
                    );
                  }
                  return _SubscribedAreasWidget(
                    subscribedAreas: cachedAreas,
                    isRefreshing: false,
                    colorScheme: colorScheme,
                    hasError: true,
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

// Loading Widget
class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

// Empty State Widget
class _EmptyStateWidget extends StatelessWidget {
  final ColorScheme colorScheme;

  const _EmptyStateWidget({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primaryContainer.withOpacity(0.3),
            colorScheme.secondaryContainer.withOpacity(0.2),
          ],
        ),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.location_city_outlined,
            size: 48.sp,
            color: colorScheme.primary,
          ),
          SizedBox(height: 12.h),
          Text(
            'No Areas Subscribed',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Subscribe to areas to get real-time updates about issues in your neighborhood',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 16.h),
          BaseButton(
            text: 'Browse Areas',
            onPressed: () {
              // context.push(Routes.areaSubscriptions);
            },
            textStyle: TextStyle(
              fontSize: 14.sp,
              color: colorScheme.onPrimary,
            ),
            backgroundColor: colorScheme.primary,
            // textColor: colorScheme.onPrimary,
            borderRadius: 12.r,
            // height: 40.h,
          ),
        ],
      ),
    );
  }
}

// Subscribed Areas Widget
class _SubscribedAreasWidget extends StatelessWidget {
  final List<String> subscribedAreas;
  final bool isRefreshing;
  final ColorScheme colorScheme;
  final bool hasError;

  const _SubscribedAreasWidget({
    required this.subscribedAreas,
    required this.isRefreshing,
    required this.colorScheme,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (hasError)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            margin: EdgeInsets.only(bottom: 8.h),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16.sp,
                  color: colorScheme.onErrorContainer,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Showing cached data',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),

        SizedBox(
          height: 140.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: subscribedAreas.length,
            itemBuilder: (context, index) {
              final area = subscribedAreas[index];
              return _AreaCard(
                areaName: area,
                colorScheme: colorScheme,
                onTap: () {
                  context.push(                    Routes.areaIssuesChat.replaceAll(':area', area),
                    extra: area,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// Individual Area Card
class _AreaCard extends StatelessWidget {
  final String areaName;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const _AreaCard({
    required this.areaName,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      margin: EdgeInsets.only(right: 12.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary.withOpacity(0.8),
                  colorScheme.primary.withOpacity(0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      areaName[0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  areaName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.sp,
                  color: colorScheme.onPrimary.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Error Widget
class _ErrorWidget extends StatelessWidget {
  final String message;
  final ColorScheme colorScheme;

  const _ErrorWidget({required this.message, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: colorScheme.errorContainer.withOpacity(0.3),
        border: Border.all(color: colorScheme.error.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: colorScheme.error),
          SizedBox(height: 12.h),
          Text(
            'Unable to Load Areas',
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
          BaseButton(
            text: 'Retry',
            onPressed: () {
              context.read<AreaSubscriptionCubit>().refresh();
            },
            backgroundColor: colorScheme.error,
            textStyle: TextStyle(
              color: colorScheme.onErrorContainer,
              fontSize: 14.sp,
            ),
            borderRadius: 12.r,
          ),
        ],
      ),
    );
  }
}
