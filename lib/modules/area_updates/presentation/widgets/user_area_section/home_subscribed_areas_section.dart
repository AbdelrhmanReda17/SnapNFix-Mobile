import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/subscribed_areas_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/user_area_section/see_all_card.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/shared_error_widget.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/user_area_section/area_card.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class HomeSubscribedAreasSection extends StatefulWidget {
  const HomeSubscribedAreasSection({super.key});

  @override
  State<HomeSubscribedAreasSection> createState() =>
      _HomeSubscribedAreasSectionState();
}

class _HomeSubscribedAreasSectionState
    extends State<HomeSubscribedAreasSection> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<SubscribedAreasCubit>();
      debugPrint('🏠 Home section using cubit instance: ${cubit.hashCode}');
      cubit.loadForHome();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, colorScheme),
          SizedBox(height: 12.h),
          RefreshIndicator(
            onRefresh: () async {
              await context.read<SubscribedAreasCubit>().refresh();
            },
            child: BlocBuilder<SubscribedAreasCubit, SubscribedAreasState>(
              builder: (context, state) {
                return state.when(
                  initial: () {
                    return _buildLoadingWidget();
                  },
                  loading: () {
                    return _buildLoadingWidget();
                  },
                  loaded: (subscribedAreas, _, __, ___, ____, _____) {
                    if (subscribedAreas.isEmpty) {
                      return _buildEmptyState(colorScheme);
                    }
                    return _buildSubscribedAreasList(
                      subscribedAreas,
                      colorScheme,
                      false,
                    );
                  },
                  error: (error) {
                    return SharedErrorWidget(
                      message:
                          AppLocalizations.of(
                            context,
                          )!.failedToLoadSubscribedAreas,
                      colorScheme: colorScheme,
                      onRetry: () {
                        context.read<SubscribedAreasCubit>().loadForHome();
                      },
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.yourAreas,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                context.push(Routes.allAreas);
              },
              icon: Icon(Icons.add, size: 20.sp, color: colorScheme.primary),
              tooltip: AppLocalizations.of(context)!.manageAreas,
            ),
            BlocBuilder<SubscribedAreasCubit, SubscribedAreasState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context.read<SubscribedAreasCubit>().loadForHome();
                  },
                  icon: Icon(
                    Icons.refresh,
                    size: 20.sp,
                    color: colorScheme.primary,
                  ),
                  tooltip: AppLocalizations.of(context)!.refresh,
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      height: 120.h,
      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme) {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off_outlined,
              size: 32.sp,
              color: colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: 8.h),
            Text(
              AppLocalizations.of(context)!.noSubscribedAreas,
              style: TextStyle(
                fontSize: 14.sp,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              AppLocalizations.of(context)!.tapToAddAreas,
              style: TextStyle(
                fontSize: 12.sp,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscribedAreasList(
    List<AreaInfo> subscribedAreas,
    ColorScheme colorScheme,
    bool isLoading,
  ) {
    return Column(
      children: [
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                subscribedAreas.length > 4
                    ? subscribedAreas.length + 1
                    : subscribedAreas.length,
            itemBuilder: (context, index) {
              if (subscribedAreas.length > 4 &&
                  index == subscribedAreas.length) {
                return SeeAllCard(
                  colorScheme: colorScheme,
                  onTap: () {
                    context.push(
                      Routes.allAreas,
                      extra: {'showSubscribed': true},
                    );
                  },
                );
              }
              final area = subscribedAreas[index];
              return AreaCard(
                area: area,
                colorScheme: colorScheme,
                onTap: () {
                  context.push(Routes.areaIssues, extra: area);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
