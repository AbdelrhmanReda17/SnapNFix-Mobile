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
        Text(title, textAlign: TextAlign.center, style: TextStyles.h1),
        SizedBox(height: 10.w),
        Text(description, textAlign: TextAlign.center, style: TextStyles.body2),
      ],
    );
  }
}
