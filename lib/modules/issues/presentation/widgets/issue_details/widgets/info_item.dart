import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String? label;
  final String? value;
  final Color color;
  final Widget? child;

  const InfoItem({
    super.key,
    required this.icon,
    this.label,
    this.value,
    required this.color,
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: isTablet ? 18.sp : 16.sp, color: color),
        SizedBox(width: isTablet ? 12.w : 10.w),
        Expanded(
          child:
              child ??
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$label: ',
                      style: TextStyle(
                        fontSize: isTablet ? 14.sp : 13.sp,
                        color:
                            isDarkMode
                                ? colorScheme.primary
                                : colorScheme.secondary,
                        height: 1.3,
                      ),
                    ),
                    TextSpan(
                      text: value,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: isTablet ? 14.sp : 13.sp,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ],
    );
  }
}
