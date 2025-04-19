import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/helpers/spacing.dart';

class ApplicationLogoAndName extends StatelessWidget {
  const ApplicationLogoAndName({super.key});

  @override
  Widget build(BuildContext context) {
    // check if it dark mode or light mode
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/SnapNFix.png', height: 45.h),
        horizontalSpace(9),
        isDark
            ? Image.asset('assets/images/SNF_dark.png', height: 30.h)
            : Image.asset('assets/images/SNF.png', height: 30.h),
      ],
    );
  }
}
