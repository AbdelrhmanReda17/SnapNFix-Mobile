import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/home_header.dart';
import '../widgets/horizontal_cards.dart';
import '../widgets/report_section.dart';
import '../widgets/channels_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),
            SizedBox(height: 4.h),
            const HorizontalCards(),
            SizedBox(height: 4.h),
            const ReportSection(),
            SizedBox(height: 4.h),
            const Expanded(
              child: ChannelsSection(),
            ),
          ],
        ),
      ],
    );
  }
}
