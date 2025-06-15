import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String? text;
  final Color color;
  final Widget? child;

  const InfoItem({
    super.key,
    required this.icon,
    this.text,
    required this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18.sp, color: color),
        SizedBox(width: 12.w),
        Expanded(
          child: child ?? Text(
            text!,
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
