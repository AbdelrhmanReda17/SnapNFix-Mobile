import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/number_formatter.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/report_statistics_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/report_statistics_state.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';
import 'package:snapnfix/presentation/widgets/enhanced_card.dart';

class HorizontalCards extends StatelessWidget {
  const HorizontalCards({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;

    return BlocBuilder<ReportStatisticsCubit, ReportStatisticsState>(
      builder: (context, state) {
        final pendingCount = state.statistics?.pendingReports ?? 0;
        final approvedCount = state.statistics?.approvedReports ?? 0;
        final isLoading = state.isLoading;

        return SizedBox(
          height: 240.h,
          child:
              state.error != null
                  ? _buildErrorView(context, state.error!)
                  : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    physics: const BouncingScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: index < 2 ? 12.w : 0,
                          top: 8.h,
                          bottom: 16.h,
                        ),
                        child: _buildCard(
                          context,
                          index,
                          theme,
                          localization,
                          pendingCount,
                          approvedCount,
                          isLoading,
                        ),
                      );
                    },
                  ),
        );
      },
    );
  }

  Widget _buildErrorView(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 48.h,
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 16.h),
            FilledButton(
              onPressed: () {
                context.read<ReportStatisticsCubit>().loadStatistics();
              },
              child: Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    int index,
    ThemeData theme,
    AppLocalizations localization,
    int pendingCount,
    int approvedCount,
    bool isLoading,
  ) {
    final primaryColor = theme.colorScheme.primary;
    final isDarkMode = theme.brightness == Brightness.dark;

    // Use a single style based on theme mode
    final cardStyle =
        isDarkMode
            ? CardStyle(
              backgroundColor: const Color.fromRGBO(255, 255, 255, 0.08),
              gradient: null,
            )
            : CardStyle(
              backgroundColor: null,
              gradient: LinearGradient(
                // ignore: deprecated_member_use
                colors: [primaryColor.withOpacity(0.7), primaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            );

    // Card content based on index
    if (index == 0) {
      return EnhancedCard(
        title: localization.loyaltyPoints,
        mainValue: NumberFormatter.localizeNumber(850, localization),
        valueSuffix: localization.points,
        description: localization.earnMorePointsDescription,
        buttonText: localization.claim,
        onButtonPressed: () => context.go(Routes.submitReport),
        isLoading: isLoading,
        cardStyle: cardStyle,
        iconData: Icons.workspace_premium,
      );
    } else if (index == 1) {
      return EnhancedCard(
        title: localization.pendingReports,
        mainValue: NumberFormatter.localizeNumber(pendingCount, localization),
        valueSuffix: localization.reports,
        description: localization.issuesBeingReviewed,
        buttonText: localization.viewDetails,
        onButtonPressed: () => context.go(Routes.userReports),
        isLoading: isLoading,
        cardStyle: cardStyle,
        iconData: Icons.pending_actions,
      );
    } else {
      return EnhancedCard(
        title: localization.approvedReports,
        mainValue: NumberFormatter.localizeNumber(approvedCount, localization),
        valueSuffix: localization.reports,
        description: localization.aiRecognized,
        buttonText: localization.viewDetails,
        onButtonPressed: () => context.go(Routes.userReports),
        isLoading: isLoading,
        cardStyle: cardStyle,
        iconData: Icons.check_circle,
      );
    }
  }
}
