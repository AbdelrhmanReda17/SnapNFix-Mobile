import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';

class IssueDetailItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final double borderRadius;
  final double iconTextSpacing;
  final EdgeInsets? padding;

  const IssueDetailItem({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    this.borderRadius = 8.0,
    this.iconTextSpacing = 8.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      child: IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18.r, color: color),
            horizontalSpace(iconTextSpacing),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}