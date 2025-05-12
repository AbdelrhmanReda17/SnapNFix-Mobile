import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../cubits/area_updates_cubit.dart';
import '../cubits/area_updates_state.dart';
import '../navigation/routes.dart';
import 'buttons/area_circle_button.dart';
class AreaUpdatesSectionContent extends StatelessWidget {
  const AreaUpdatesSectionContent({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Area Updates',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          BlocBuilder<AreaUpdatesCubit, AreaUpdatesState>(
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: Row(
                  children: state.areas.map((area) {
                    final isSelected = area == state.selectedArea;
                    final heroTag = 'area-hero-$area';
                    return Padding(
                      padding: EdgeInsets.only(right: 17.w),
                      child: GestureDetector(
                        onTap: () {
                          context.read<AreaUpdatesCubit>().selectArea(area);
                          context.push(
                            Routes.areaIssuesChat,
                            extra: area
                          );
                        },
                        child: Column(
                          children: [
                            Hero(
                              tag: heroTag,
                              child: AreaCircleButton(
                                label: area,
                                isSelected: isSelected,
                                colorScheme: colorScheme,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            // Area label text
                            Text(
                              area,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}