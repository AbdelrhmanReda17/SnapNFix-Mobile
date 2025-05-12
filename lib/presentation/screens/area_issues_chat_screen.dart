import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/issues/domain/usecases/get_area_issues_use_case.dart';
import 'package:snapnfix/presentation/cubits/area_issues_cubit.dart';
import 'package:snapnfix/presentation/widgets/area_issues/area_issues_header.dart';
import 'package:snapnfix/presentation/widgets/area_issues/area_issues_list.dart';

class AreaIssuesChatScreen extends StatelessWidget {
  final String area;

  AreaIssuesChatScreen({
    String? area,
    Map<String, dynamic>? extra,
    super.key
  })  : area = area ?? extra?['area'] as String;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final heroTag = 'area-hero-$area'; // Generate tag based on area name

    return BlocProvider(
      create: (context) => AreaIssuesCubit(
        areaName: area,
        getAreaIssuesUseCase: getIt<GetAreaIssuesUseCase>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Hero(
                tag: heroTag,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.8.r,
                      colors: [const Color(0xFF23576D), colorScheme.primary],
                      stops: const [0.0, 1.0],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      area[0],
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                '$area Issues',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            // Area header with subscription and filter buttons
            const AreaIssuesHeader(),
            
            // Issue list with pull-to-refresh
            const Expanded(
              child: AreaIssuesList(),
            ),
          ],
        ),
      ),
    );
  }
}