import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/marker_dialog/issue_marker_dialog.dart';

class IssueDetailsDialog {
  static Future<void> show({
    required BuildContext context,
    required String issueId,
    required VoidCallback onDialogClosed,
    VoidCallback? onReportTap,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => Dialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            insetPadding: EdgeInsets.symmetric(
              horizontal: 17.w,
              vertical: 16.h,
            ),
            child: IssueMarkerDialog(
              issueId: issueId,
              onTap: () {
                Navigator.pop(context);
                onReportTap?.call();
              },
            ),
          ),
    ).then((_) => onDialogClosed());
  }
}
