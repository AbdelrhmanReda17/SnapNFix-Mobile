import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/routes.dart';
import 'package:snapnfix/features/authentication/logic/cubit/login_cubit.dart';
import 'package:snapnfix/features/authentication/logic/cubit/sign_up_cubit.dart';

class ScreenItem {
  final String path;
  final Widget screen;
  final Widget Function(Widget child)? blocProvider;
  final String? icon;
  final String? activeIcon;

  ScreenItem({
    this.blocProvider,
    required this.screen,
    this.icon,
    this.activeIcon,
    required this.path,
  });

  Widget get wrappedWidget =>
      blocProvider != null ? blocProvider!(screen) : screen;
}

class ApplicationScreens {
  static final List<ScreenItem> screens = [
    ScreenItem(
      path: Routes.signUpScreen.key,
      screen: Routes.signUpScreen.value,
      blocProvider: (child) {
        return BlocProvider(
          create: (context) => getIt<SignUpCubit>(),
          child: child,
        );
      },
    ),
    ScreenItem(
      path: Routes.loginScreen.key,
      screen: Routes.loginScreen.value,
      blocProvider: (child) {
        return BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: child,
        );
      },
    ),
    ScreenItem(
      screen: Routes.onBoardingScreen.value,
      path: Routes.onBoardingScreen.key,
    ),
  ];

  static final List<ScreenItem> navigationScreens = [
    ScreenItem(
      screen: Routes.homeScreen.value,
      path: Routes.homeScreen.key,
      icon: 'assets/icons/home.svg',
      activeIcon: 'assets/icons/active/home.svg',
    ),
    ScreenItem(
      screen: Routes.mapScreen.value,
      path: Routes.mapScreen.key,
      icon: 'assets/icons/map.svg',
      activeIcon: 'assets/icons/active/map.svg',
    ),
    ScreenItem(
      screen: Routes.userReportsScreen.value,
      path: Routes.userReportsScreen.key,
      icon: 'assets/icons/user_reports.svg',
      activeIcon: 'assets/icons/active/user_reports.svg',
    ),
    ScreenItem(
      screen: Routes.settingsScreen.value,
      path: Routes.settingsScreen.key,
      icon: 'assets/icons/settings.svg',
      activeIcon: 'assets/icons/active/settings.svg',
    ),
  ];

  static final ScreenItem fab = ScreenItem(
    screen: Routes.addReportScreen.value,
    path: Routes.addReportScreen.key,
    icon: 'assets/icons/add_report.svg',
    activeIcon: 'assets/icons/active/add_report.svg',
  );
}
