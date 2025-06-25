import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/index.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_fast_report_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/fast_report/fast_report_dialog_content.dart';

class FastReportDialog extends StatelessWidget {
  final String issueId;
  final VoidCallback onSuccess;

  const FastReportDialog({
    super.key,
    required this.issueId,
    required this.onSuccess,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String issueId,
    required VoidCallback onSuccess,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => BlocProvider(
            create: (context) => getIt<SubmitFastReportCubit>(),
            child: FastReportDialog(issueId: issueId, onSuccess: onSuccess),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final dialogWidth = screenSize.width * 0.95;
    final dialogHeight = screenSize.height * 0.55;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Container(
        width: dialogWidth,
        constraints: BoxConstraints(maxHeight: dialogHeight),
        child: FastReportDialogContent(issueId: issueId, onSuccess: onSuccess),
      ),
    );
  }
}
