import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/application_constants.dart';
import 'package:snapnfix/core/helpers/shared_pref_helper.dart';
import 'package:snapnfix/core/helpers/shared_pref_keys.dart';
import 'package:snapnfix/core/routes.dart';
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
  double currentPage = 0;

  void setViewOnBoarding() async {
    await SharedPrefHelper.setData(SharedPrefKeys.hasViewedOnboarding, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            !(currentPage == ApplicationConstants.onboardingContent.length - 1)
                ? SkipButton(controller: _controller)
                : SizedBox(height: 50.h),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (int page) {
                  setState(() {
                    currentPage = page.toDouble();
                  });
                },
                children: [...buildOnBoardingPages()],
              ),
            ),
            PageIndicator(controller: _controller),
            SizedBox(height: 20.h),
            NextButton(
              progress:
                  currentPage /
                  (ApplicationConstants.onboardingContent.length - 1),
              onPressed: () => nextButtonOnPressed(context),
            ),
          ],
        ),
      ),
    );
  }

  void nextButtonOnPressed(BuildContext context) {
    if (currentPage == ApplicationConstants.onboardingContent.length - 1) {
      setViewOnBoarding();
      context.go(Routes.loginScreen.key);
    } else {
      _controller.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  Iterable<Widget> buildOnBoardingPages() {
    return ApplicationConstants.onboardingContent.map(
      (content) => OnboardingPage(
        image: content['image']!,
        title: content['title']!,
        description: content['description']!,
      ),
    );
  }
}
