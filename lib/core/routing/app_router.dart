import 'package:flutter/material.dart';
import 'package:snapnfix/core/routing/routes.dart';
import 'package:snapnfix/features/login/presentation/screens/login_screen.dart';
import 'package:snapnfix/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:snapnfix/features/sign_up/presentation/screens/sign_up_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      default:
        return null;
    }
  }
}
