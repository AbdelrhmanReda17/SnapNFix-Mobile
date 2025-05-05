import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'issue_marker_dialog_image.dart';
import 'issue_marker_dialog_status_badge.dart';
import '../../../domain/entities/issue.dart';

class IssueMarkerDialogHeader extends StatelessWidget {
  final Issue issue;

  const IssueMarkerDialogHeader({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IssueMarkerDialogImage(
          imageUrl:
              issue.images.isNotEmpty ? issue.images.first : null,
        ),
        Positioned(
          top: 12.r,
          right: 12.r,
          child: IssueMarkerDialogStatusBadge(status: issue.status, size: 16.r),
        ),
      ],
    );
  }
}
