import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/constants/constants.dart';
import 'package:snapnfix/core/theming/text_styles.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key, required PageController controller})
    : _controller = controller;

  final PageController _controller;
  @override
  Widget build(BuildContext context) {
    return BaseButton(
      text: 'Skip',
      backgroundColor: Colors.transparent,
      onPressed: () {
        _controller.animateToPage(
          Constants.onboardingContent.length - 1,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
      textStyle: TextStyles.font14Normal(TextColor.primaryColor),
      buttonWidth: 30.w,
    );
  }
}
