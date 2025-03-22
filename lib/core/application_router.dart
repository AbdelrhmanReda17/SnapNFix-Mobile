import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/routes.dart';
import 'package:snapnfix/features/home/presentation/home_screen.dart';
import 'package:snapnfix/features/authentication/logic/cubit/login_cubit.dart';
import 'package:snapnfix/features/authentication/presentation/screens/login_screen.dart';
import 'package:snapnfix/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:snapnfix/features/authentication/logic/cubit/sign_up_cubit.dart';
import 'package:snapnfix/features/authentication/presentation/screens/sign_up_screen.dart';

class ApplicatinoRouter {
  Route? generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<LoginCubit>(),
                child: const LoginScreen(),
              ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<SignUpCubit>(),
                child: const SignUpScreen(),
              ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return null;
    }
  }
}
