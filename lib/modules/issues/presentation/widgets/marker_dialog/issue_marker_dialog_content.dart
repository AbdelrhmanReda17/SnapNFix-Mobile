import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'issue_marker_dialog_detail_item.dart';
import 'issue_marker_dialog_action.dart';
import '../../../domain/entities/issue.dart';

class IssueMarkerDialogContent extends StatelessWidget {
  final Issue issue;
  final VoidCallback? onReportTap;

  const IssueMarkerDialogContent({
    super.key,
    required this.issue,
    this.onReportTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: IssueMarkerDialogDetailItem(
                  icon: Icons.category,
                  text: issue.category.displayName,
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: IssueMarkerDialogDetailItem(
                  icon: Icons.report_problem_outlined,
                  text: '${issue.reports.length} Reports',
                  color: colorScheme.secondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          IssueMarkerDialogAction(onTap: onReportTap),
        ],
      ),
    );
  }
}