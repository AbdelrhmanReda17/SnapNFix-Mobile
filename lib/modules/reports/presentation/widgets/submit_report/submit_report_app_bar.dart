import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_report_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/utils/report_timeout_manager.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/submit_report/submit_report_tips.dart';

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

    return AppBar(
      backgroundColor: colorScheme.surface,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: BlocBuilder<SubmitReportCubit, SubmitReportState>(
        builder: (context, state) {
          if (state.image != null || state.details != null) {
            return ValueListenableBuilder<int>(
              valueListenable: timeoutManager.timeRemainingNotifier,
              builder: (context, secondsRemaining, _) {
                return Center(
                  child: Text(
                    _formatTime(secondsRemaining),
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
        "Report an Incident",
        style: textStyles.headlineLarge?.copyWith(
          fontSize: 20.sp,
          color: colorScheme.primary,
        ),
      ),
      actions: [
        GestureDetector(onTap: onTipsPressed, child: SubmitReportTips()),
      ],
      elevation: 0,
    );
  }

  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
