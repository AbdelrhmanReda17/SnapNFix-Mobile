import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/subscribed_areas_cubit.dart';
import '../widgets/home_header.dart';
import '../../modules/reports/presentation/widgets/reports_statistics/reports_statistics.dart';
import '../widgets/report_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/user_area_section/home_subscribed_areas_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            const HomeHeader(),
            SizedBox(height: 4.h),
            const ReportsStatistics(),
            SizedBox(height: 4.h),
            const ReportSection(),
            SizedBox(height: 8.h),
            BlocProvider(
              create: (context) => getIt<SubscribedAreasCubit>(),
              child: HomeSubscribedAreasSection(),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ],
    );
  }
}
