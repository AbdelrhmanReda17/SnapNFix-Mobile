import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/report_review_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_card.dart';

class UserReportsScreen extends StatelessWidget {
  const UserReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localization = AppLocalizations.of(context)!;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: colorScheme.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(62.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppBar(
              backgroundColor: colorScheme.surface,
              titleSpacing: 0,
              centerTitle: true,
              elevation: 0,
              title: Text(
                localization.myReports,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<ReportReviewCubit, ReportReviewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Text(
                state.error!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (state.reports.isEmpty) {
            return Center(
              child: Text(
                localization.noReports,
                style: theme.textTheme.bodyLarge,
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.r),
            itemCount: state.reports.length,
            itemBuilder: (context, index) {
              final report = state.reports[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 16.r),
                child: ReportCard(report: report),
              );
            },
          );
        },
      ),
    );
  }
}
