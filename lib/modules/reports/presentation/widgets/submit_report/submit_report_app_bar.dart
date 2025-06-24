import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_report_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/utils/report_timeout_manager.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/submit_report/submit_report_tips.dart';
import 'package:snapnfix/core/utils/helpers/number_formatter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubmitReportAppBar extends StatelessWidget {
  final ReportTimeoutManager timeoutManager;
  final VoidCallback onTipsPressed;

  const SubmitReportAppBar({
    super.key,
    required this.timeoutManager,
    required this.onTipsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final localization = AppLocalizations.of(context)!;

    return AppBar(
      backgroundColor: colorScheme.surface,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: BlocBuilder<SubmitReportCubit, SubmitReportState>(
        builder: (context, state) {
          if (state.image != null || state.comment != null) {
            return ValueListenableBuilder<int>(
              valueListenable: timeoutManager.timeRemainingNotifier,
              builder: (context, secondsRemaining, _) {
                final minutes = (secondsRemaining / 60).floor();
                final seconds = secondsRemaining % 60;
                return Center(
                  child: Text(
                    "${NumberFormatter.localizeNumber(minutes, localization)}:${NumberFormatter.localizeNumber(seconds.toString().padLeft(2, '0'), localization)}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color:
                          secondsRemaining <= 60
                              ? colorScheme.error
                              : colorScheme.primary,
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      title: Text(
        localization.reportAnIncident,
        style: textStyles.headlineLarge?.copyWith(
          fontSize: 20.sp,
          color: colorScheme.tertiary,
        ),
      ),
      actions: [
        GestureDetector(onTap: onTipsPressed, child: SubmitReportTips()),
      ],
      elevation: 0,
    );
  }
}
