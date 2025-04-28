import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';
import 'package:snapnfix/presentation/widgets/home_card.dart';

class HorizontalCards extends StatelessWidget {
  const HorizontalCards({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 220.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        children: [
          CustomCard(
            title: "Loyalty Points",
            mainValue: "850",
            valueSuffix: "Pts",
            description: "Earn more points and Enjoy benefits",
            buttonText: "Claim",
            onButtonPressed: () => context.go(Routes.submitReportScreen.key),
            imageAsset: 'assets/images/medal.png',
            imageWidth: 70.w,
            imageHeight: 70.w,
            imageOffset: Offset(-7.w, 0.h),
            colorScheme: theme.colorScheme,
          ),
          SizedBox(width: 12.w),
          CustomCard(
            title: "Pending Reports",
            mainValue: "3",
            valueSuffix: "reports",
            description: "Your issues are being reviewed.",
            buttonText: "View Details",
            onButtonPressed: () => context.go(Routes.userReportsScreen.key),
            colorScheme: theme.colorScheme,
          ),
          SizedBox(width: 12.w),
          CustomCard(
            title: "Resolved Reports",
            mainValue: "7",
            valueSuffix: "reports",
            description: "You've made a difference!.",
            buttonText: "View Details",
            onButtonPressed: () => context.go(Routes.userReportsScreen.key),
            colorScheme: theme.colorScheme,
          ),
        ],
      ),
    );
  }
}
