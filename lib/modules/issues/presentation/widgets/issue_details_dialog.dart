import 'package:flutter/material.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/marker_dialog/issue_marker_dialog.dart';

class IssueDetailsDialog {
  static Future<void> show({
    required BuildContext context,
    required Issue issue,
    required VoidCallback onDialogClosed,
    VoidCallback? onReportTap,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            child: IssueMarkerDialog(
              issue: issue,
              onReportTap: () {
                Navigator.pop(context);
                onReportTap?.call();
              },
            ),
          ),
    ).then((_) => onDialogClosed());
  }
}
