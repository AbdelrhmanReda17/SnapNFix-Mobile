import 'package:flutter/material.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
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
            verticalSpace(4),
            const HorizontalCards(),
            verticalSpace(4),
            const ReportSection(),
            verticalSpace(4),
            const Expanded(
              child: ChannelsSection(),
            ),
          ],
        ),
      ],
    );
  }
}
