import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:snapnfix/core/constants/constants.dart';
import 'package:snapnfix/core/theming/colors.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required PageController controller})
    : _controller = controller;

  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: _controller,
      count: Constants.onboardingContent.length,
      effect: WormEffect(
        dotWidth: 10,
        dotHeight: 10,
        activeDotColor: ColorsManager.primaryColor,
      ),
    );
  }
}
