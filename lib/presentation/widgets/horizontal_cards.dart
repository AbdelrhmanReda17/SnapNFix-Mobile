import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/number_formatter.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/report_statistics_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/report_statistics_state.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';
import 'package:snapnfix/presentation/widgets/home_card.dart';

class HorizontalCards extends StatelessWidget {
  const HorizontalCards({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;

    return BlocBuilder<ReportStatisticsCubit, ReportStatisticsState>(
      builder: (context, state) {
        final pendingCount = state.statistics?.pendingReports ?? 3;
        final approvedCount = state.statistics?.approvedReports ?? 7;

        return SizedBox(
          height: 220.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            children: [
              CustomCard(
                title: localization.loyaltyPoints,
                mainValue: NumberFormatter.localizeNumber(850, localization),
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
                mainValue: NumberFormatter.localizeNumber(pendingCount, localization),
                valueSuffix: localization.reports,
                description: localization.issuesBeingReviewed,
                buttonText: localization.viewDetails,
                onButtonPressed: () => context.go(Routes.userReports),
                colorScheme: theme.colorScheme,
              ),
              horizontalSpace(12),
              CustomCard(
                title: localization.approvedReports,
                mainValue: NumberFormatter.localizeNumber(approvedCount, localization),
                valueSuffix: localization.reports,
                description: localization.aiRecognized,
                buttonText: localization.viewDetails,
                onButtonPressed: () => context.go(Routes.userReports),
                colorScheme: theme.colorScheme,
              ),
            ],
          ),
        );
      },
    );
  }
}
