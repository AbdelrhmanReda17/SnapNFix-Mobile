import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/home_header.dart';
import '../widgets/horizontal_cards.dart';
import '../widgets/report_section.dart';
import '../widgets/nearby_issues_section.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: const NearbyIssuesSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
