import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/theming/text_styles.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image),
        SizedBox(height: 20.w),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyles.font24Bold(TextColor.primaryColor),
        ),
        SizedBox(height: 10.w),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyles.font12Normal(TextColor.secondaryColor),
          ),
        ),
      ],
    );
  }
}
