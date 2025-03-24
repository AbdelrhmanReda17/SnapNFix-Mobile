import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/spacing.dart';

class ApplicationLogoAndName extends StatelessWidget {
  const ApplicationLogoAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/SnapNFix.png',
          height: 45.h,
        ),
        horizontalSpace(9),
        Image.asset(
          'assets/images/SNF.png',
          height: 30.h,
        ),
      ],
    );
  }
}
