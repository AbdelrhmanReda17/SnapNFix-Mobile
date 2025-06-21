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
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon, 
          size: isTablet ? 18.sp : 16.sp, 
          color: color
        ),
        SizedBox(width: isTablet ? 12.w : 10.w),
        Expanded(
          child: child ?? Text(
            text!,
            style: TextStyle(
              fontSize: isTablet ? 14.sp : 13.sp,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}
