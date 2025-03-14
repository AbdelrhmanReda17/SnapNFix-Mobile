import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/constants/constants.dart';
import 'package:snapnfix/core/theming/colors.dart';
import 'package:snapnfix/core/theming/text_styles.dart';
import 'package:snapnfix/features/onboarding/presentation/widgets/next_button.dart';
import 'package:snapnfix/features/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:snapnfix/features/onboarding/presentation/widgets/page_indicator.dart';
import 'package:snapnfix/features/onboarding/presentation/widgets/skip_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == Constants.onboardingContent.length - 1;
                });
              },
              children: [...buildOnBoardingPages()],
            ),
          ),
          PageIndicator(controller: _controller),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child:
                !isLastPage
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SkipButton(
                          isLastPage: isLastPage,
                          controller: _controller,
                        ),
                        NextButton(
                          isLastPage: isLastPage,
                          controller: _controller,
                        ),
                      ],
                    )
                    : BaseButton(
                      text: 'Get Started',
                      onPressed: () {},
                      textStyle: TextStyles.font12Normal(TextColor.quaternaryColor),
                    ),
          ),
        ],
      ),
    );
  }

  Iterable<Widget> buildOnBoardingPages() {
    return Constants.onboardingContent.map(
      (content) => OnboardingPage(
        image: content['image']!,
        title: content['title']!,
        description: content['description']!,
      ),
    );
  }
}
