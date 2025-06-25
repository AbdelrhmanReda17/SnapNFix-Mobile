import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';

class IssueMarkerDialogStatusBadge extends StatelessWidget {
  final IssueStatus status;
  final double size;

  const IssueMarkerDialogStatusBadge({
    super.key,
    required this.status,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getStatusIcon(), size: size.r, color: _getStatusColor()),
          horizontalSpace(4),
          Text(
            _getStatusText(),
            style: TextStyle(
              color: _getStatusColor(),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case IssueStatus.pending:
        return Colors.orange;
      case IssueStatus.inProgress:
        return Colors.blue;
      case IssueStatus.completed:
        return Colors.green;
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case IssueStatus.pending:
        return Icons.pending;
      case IssueStatus.inProgress:
        return Icons.engineering;
      case IssueStatus.completed:
        return Icons.check_circle;
    }
  }

  String _getStatusText() => status.toString().split('.').last;
}
