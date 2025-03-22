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
    return Center(
      child: SmoothPageIndicator(
        controller: _controller,
        count: Constants.onboardingContent.length,
        effect: ExpandingDotsEffect(
          dotHeight: 8,
          dotWidth: 8,
          expansionFactor: 2.5, // Adjust expansion for the active dota
          spacing: 8,
          activeDotColor: ColorsManager.primaryColor,
          dotColor: ColorsManager.quaternaryColor,
        ),
      ),
    );
  }
}
