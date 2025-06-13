import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../cubits/area_updates_cubit.dart';
import '../cubits/area_updates_state.dart';
import '../navigation/routes.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AreaUpdatesSectionContent extends StatelessWidget {
  const AreaUpdatesSectionContent({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
                SizedBox(width: 8.w),
                Text(
                  'Area Updates',
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
                        ? _buildEmptyState(colorScheme)
                        : _buildAreaCards(context, state, colorScheme),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme) {
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
            'No areas to display',
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.areas.length,
        itemBuilder: (context, index) {
          final area = state.areas[index];
          final isSelected =
              area.key == state.selectedArea; // Fixed: compare with area.key

          // Create different card heights for visual interest
          final isEven = index % 2 == 0;
          final cardHeight = isEven ? 80.h : 95.h;

          // Get area icon based on name
          final IconData areaIcon = Icons.apartment;

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                context.read<AreaUpdatesCubit>().selectArea(
                  area.key,
                ); // Use area.key
                context.push(Routes.areaIssuesChat, extra: area.key);
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
                              colorScheme.secondary,
                              colorScheme.secondaryContainer,
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
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          areaIcon,
                          color:
                              isSelected ? Colors.white : colorScheme.primary,
                          size: 24.sp,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? Colors.white.withOpacity(0.2)
                                    : colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            area.value,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color:
                                  isSelected
                                      ? Colors.white
                                      : colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      area.key,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color:
                            isSelected ? Colors.white : colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
