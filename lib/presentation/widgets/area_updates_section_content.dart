import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import '../cubits/area_updates_cubit.dart';
import '../cubits/area_updates_state.dart';
import '../navigation/routes.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AreaUpdatesSectionContent extends StatelessWidget {
  const AreaUpdatesSectionContent({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Container(
                  height: 24.h,
                  width: 4.w,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                horizontalSpace(8),
                Text(
                  localization.areaUpdates,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.refresh_rounded, color: colorScheme.primary),
                  onPressed: () => {},
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          BlocBuilder<AreaUpdatesCubit, AreaUpdatesState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child:
                    state.areas.isEmpty
                        ? _buildEmptyState(colorScheme, localization)
                        : _buildAreaCards(context, state, colorScheme),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(
    ColorScheme colorScheme,
    AppLocalizations localization,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_city_outlined,
            size: 64.sp,
            color: colorScheme.primary.withValues(alpha: 0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            localization.noAreasToDisplay,
            style: TextStyle(
              fontSize: 16.sp,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAreaCards(
    BuildContext context,
    AreaUpdatesState state,
    ColorScheme colorScheme,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    double cardSpacing = 8.w;

    if (screenWidth > 600) {
      crossAxisCount = 3;
      cardSpacing = 10.w;
    } else if (screenWidth < 380) {
      crossAxisCount = 1;
      cardSpacing = 12.w;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: MasonryGridView.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: cardSpacing,
            crossAxisSpacing: cardSpacing,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.areas.length,
            itemBuilder: (context, index) {
              final area = state.areas[index];
              final isSelected =
                  area.key ==
                  state
                      .selectedArea; // Dynamic but controlled card height with more compact spacing
              final baseHeight = 75.h;
              final maxHeight = 90.h;
              final calculatedHeight = baseHeight + (index % 3 * 5.h);
              final cardHeight = calculatedHeight.clamp(baseHeight, maxHeight);
              final IconData areaIcon = Icons.home_work;

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    context.read<AreaUpdatesCubit>().selectArea(area.key);
                    context.push(Routes.areaIssues, extra: area.key);
                  },
                  borderRadius: BorderRadius.circular(16.r),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: cardHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors:
                            isSelected
                                ? [
                                  colorScheme.primary,
                                  colorScheme.primary.withValues(alpha: 0.8),
                                ]
                                : [
                                  colorScheme.surfaceContainerHighest,
                                  colorScheme.surface,
                                ],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withValues(
                            alpha: isDarkMode ? 0.3 : 0.1,
                          ),
                          spreadRadius: isDarkMode ? 1 : 2,
                          blurRadius: isDarkMode ? 3 : 8,
                          offset: Offset(0, isDarkMode ? 2 : 3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(12.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Top row with icon and badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              areaIcon,
                              color:
                                  isSelected
                                      ? colorScheme.onPrimary
                                      : colorScheme.primary,
                              size: 20.sp,
                            ),
                            if (area.value.isNotEmpty)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? colorScheme.onPrimary.withValues(
                                            alpha: 0.2,
                                          )
                                          : colorScheme.surfaceTint,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  area.value,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isSelected
                                            ? colorScheme.onPrimary
                                            : colorScheme.onSurfaceVariant,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ],
                        ), // Area name with reduced spacing
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            area.key,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color:
                                  isSelected
                                      ? colorScheme.onPrimary
                                      : colorScheme.onSurface,
                              height: 1.2,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
