import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubmitReportNote extends StatelessWidget {
  const SubmitReportNote({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: colorScheme.primary.withValues(alpha: .2),
          width: 1,
        ),
      ),
      color: colorScheme.primary.withValues(alpha: 0.05),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: colorScheme.primary.withValues(alpha: .1),
              child: SvgPicture.asset(
                'assets/icons/time_and_location.svg',
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
                width: 75.w,
                height: 75.h,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location & Time',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'When you submit your report, the location and time will be automatically recorded',
                    style: TextStyle(
                      color: colorScheme.primary.withValues(alpha: .7),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
