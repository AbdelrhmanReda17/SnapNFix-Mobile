import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/paginated_areas_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/paginated_areas_list.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class SubscribedAreasScreen extends StatelessWidget {
  const SubscribedAreasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PaginatedAreasCubit>()..initialize(subscribed: true),
      child: const SubscribedAreasView(),
    );
  }
}

class SubscribedAreasView extends StatelessWidget {
  const SubscribedAreasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Areas'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              context.push(Routes.allAreas);
            },
            icon: const Icon(Icons.add),
            tooltip: 'Add Areas',
          ),
          BlocBuilder<PaginatedAreasCubit, PaginatedAreasState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<PaginatedAreasCubit>().refresh();
                },
                icon: const Icon(Icons.refresh),
                tooltip: 'Refresh',
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<PaginatedAreasCubit, PaginatedAreasState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (areas, _, isLoadingMore, __) {
                  if (areas.isEmpty) return const SizedBox.shrink();
                  
                  return Container(
                    margin: EdgeInsets.all(16.w),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).colorScheme.primary,
                          size: 24.sp,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${areas.length} Subscribed Areas',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                '${areas.fold<int>(0, (sum, area) => sum + area.activeIssuesCount)} active issues total',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isLoadingMore)
                          SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                      ],
                    ),
                  );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
          
          // Paginated areas list
          Expanded(
            child: PaginatedAreasList(
              onAreaTap: (area) {
                context.push(Routes.areaIssues, extra: area.name);
              },
              emptyMessage: 'No subscribed areas found\nSubscribe to areas to see them here',
            ),
          ),
        ],
      ),
    );
  }
}
