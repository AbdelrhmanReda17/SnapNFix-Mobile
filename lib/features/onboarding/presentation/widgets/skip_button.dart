import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/constants/constants.dart';
import 'package:snapnfix/core/theming/text_styles.dart';
import 'package:snapnfix/core/theming/colors.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
    required this.isLastPage,
    required PageController controller,
  }) : _controller = controller;

  final bool isLastPage;
  final PageController _controller;
  @override
  Widget build(BuildContext context) {
    return BaseButton(
      text: 'Skip',
      backgroundColor: ColorsManager.quaternaryColor,
      onPressed: () {
        if (!isLastPage) {
          _controller.animateToPage(
            Constants.onboardingContent.length - 1,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
      },
      textStyle: TextStyles.body2,
      buttonWidth: 30.w,
    );
  }
}
