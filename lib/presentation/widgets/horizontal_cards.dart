import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';
import 'package:snapnfix/presentation/widgets/home_card.dart';

class HorizontalCards extends StatelessWidget {
  const HorizontalCards({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;

    return SizedBox(
      height: 220.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        children: [
          CustomCard(
            title: localization.loyaltyPoints,
            mainValue: "850",
            valueSuffix: localization.points,
            description: localization.earnMorePointsDescription,
            buttonText: localization.claim,
            onButtonPressed: () => context.go(Routes.submitReport),
            imageAsset: 'assets/images/medal.png',
            imageWidth: 70.w,
            imageHeight: 70.w,
            imageOffset: Offset(-7.w, 0.h),
            colorScheme: theme.colorScheme,
          ),
          horizontalSpace(12),
          CustomCard(
            title: localization.pendingReports,
            mainValue: "3",
            valueSuffix: localization.reports,
            description: localization.issuesBeingReviewed,
            buttonText: localization.viewDetails,
            onButtonPressed: () => context.go(Routes.userReports),
            colorScheme: theme.colorScheme,
          ),
          horizontalSpace(12),
          CustomCard(
            title: localization.resolvedReports,
            mainValue: "7",
            valueSuffix: localization.reports,
            description: localization.madeDifference,
            buttonText: localization.viewDetails,
            onButtonPressed: () => context.go(Routes.userReports),
            colorScheme: theme.colorScheme,
          ),
        ],
      ),
    );
  }
}
