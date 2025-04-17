import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/application_constants.dart';
import 'package:snapnfix/core/base_components/base_button.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key, required PageController controller})
    : _controller = controller;

  final PageController _controller;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseButton(
      text: 'Skip',
      backgroundColor: Colors.transparent,
      onPressed: () {
        _controller.animateToPage(
          ApplicationConstants.onboardingContent.length - 1,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
      textStyle: textTheme.bodyMedium!,
      buttonWidth: 30.w,
    );
  }
}
