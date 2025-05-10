import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/marker_dialog/issue_marker_dialog_content.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/marker_dialog/issue_marker_dialog_header.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/issue_card/issue_card.dart';
import '../../../domain/entities/issue.dart';

class IssueMarkerDialog extends StatelessWidget {
  final Issue issue;
  final VoidCallback? onReportTap;

  const IssueMarkerDialog({super.key, required this.issue, this.onReportTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: .1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IssueCard(
            issue: issue,
            showReportButton: true,
            onReportTap: onReportTap,
          ),
        ],
      ),
    );
  }
}
