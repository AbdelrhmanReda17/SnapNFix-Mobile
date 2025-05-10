import 'package:flutter/material.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/offline_report_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/home_header.dart';
import '../widgets/horizontal_cards.dart';
import '../widgets/report_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OfflineReportIndicator(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),
            SizedBox(height: 6.h),
            const HorizontalCards(),
            SizedBox(height: 10.h),
            const ReportSection(),
          ],
        ),
      ],
    );
  }
}
