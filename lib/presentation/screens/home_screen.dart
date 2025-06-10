import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/home_header.dart';
import '../widgets/horizontal_cards.dart';
import '../widgets/report_section.dart';
import '../widgets/area_updates_section.dart';

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
            const HorizontalCards(),
            SizedBox(height: 4.h),
            const ReportSection(),
            SizedBox(height: 8.h),
            const AreaUpdatesSection(),
          ],
        ),
      ],
    );
  }
}
