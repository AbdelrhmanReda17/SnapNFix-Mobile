import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';
class IssueStatusBadge extends StatelessWidget {
  final IssueStatus status;
  final double size;
  final bool showIcon;
  final bool showText;
  final EdgeInsets? padding;

  const IssueStatusBadge({
    super.key,
    required this.status,
    this.size = 24,
    this.showIcon = true,
    this.showText = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(status.icon, size: size.r, color: status.color),
            if (showText) SizedBox(width: 4.w),
          ],
          if (showText)
            Text(
              status.displayName,
              style: TextStyle(
                color: status.color,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}