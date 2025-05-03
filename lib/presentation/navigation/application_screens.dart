import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/forget_password/forgot_password_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/login/login_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/register/register_cubit.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/screens/otp_screen.dart';
import 'package:snapnfix/modules/issues/presentation/cubits/issue_details_cubit.dart';
import 'package:snapnfix/modules/issues/presentation/cubits/issues_map_cubit.dart';
import 'package:snapnfix/modules/issues/presentation/screens/issue_details_screen.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_report_cubit.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/change_password_cubit.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/edit_profile_cubit.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';
import 'package:snapnfix/presentation/navigation/transitions/slide_transition_page.dart';

class AnimatedScreenItem {
  final ScreenItem screenItem;
  final CustomTransitionPage Function({
    required Widget child,
    required String key,
  })
  pageBuilder;

  AnimatedScreenItem({required this.screenItem, required this.pageBuilder});
}

class ScreenItem {
  final String path;
  final Widget screen;
  final Widget Function(Widget child)? blocProvider;
  final String? icon;
  final String? activeIcon;
  final String? darkActiveIcon;

  ScreenItem({
    this.blocProvider,
    required this.screen,
    this.icon,
    this.activeIcon,
    this.darkActiveIcon,
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
          create: (context) => getIt<RegisterCubit>(),
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
    ScreenItem(
      path: Routes.otpScreen.key,
      screen: Builder(
        builder: (context) {
          final arguments = GoRouterState.of(context).extra;

          if (arguments is Map) {
            return OtpScreen(
              isFormForgotPassword: arguments['isFormForgotPassword'],
              emailOrPhoneNumber: arguments['emailOrPhoneNumber'],
            );
          } else if (arguments is String) {
            return OtpScreen(emailOrPhoneNumber: arguments);
          }

          return const OtpScreen();
        },
      ),
      blocProvider: (child) {
        return BlocProvider(
          create: (context) => getIt<OtpCubit>(),
          child: child,
        );
      },
    ),
    ScreenItem(
      path: Routes.forgotPasswordScreen.key,
      screen: Routes.forgotPasswordScreen.value,
      blocProvider: (child) {
        return BlocProvider(
          create: (context) => getIt<ForgotPasswordCubit>(),
          child: child,
        );
      },
    ),
    ScreenItem(
      path: Routes.resetPasswordScreen.key,
      screen: Routes.resetPasswordScreen.value,
      blocProvider: (child) {
        return BlocProvider(
          create: (context) => getIt<ResetPasswordCubit>(),
          child: child,
        );
      },
    ),
    ScreenItem(
      path: Routes.issueDetailsScreen.key,
      screen: Builder(
        builder: (context) {
          final issueId = GoRouterState.of(context).extra as String;
          return IssueDetailsScreen(
            issueId: issueId,
          );
        },
      ),
      blocProvider: (child) {
        return BlocProvider(
          create: (context) => getIt<IssueDetailsCubit>(),
          child: child,
        );
      },
    ),
    ScreenItem(
      path: Routes.supportScreen.key,
      screen: Routes.supportScreen.value,
    ),
    ScreenItem(
      path: Routes.termsAndConditionsScreen.key,
      screen: Routes.termsAndConditionsScreen.value,
    ),
    ScreenItem(
      path: Routes.privacyPolicyScreen.key,
      screen: Routes.privacyPolicyScreen.value,
    ),
    ScreenItem(path: Routes.aboutScreen.key, screen: Routes.aboutScreen.value),
  ];

  static final List<AnimatedScreenItem> animatedScreens = [
    AnimatedScreenItem(
      screenItem: ScreenItem(
        screen: Routes.changePassowrd.value,
        path: Routes.changePassowrd.key,
        blocProvider:
            (child) => BlocProvider(
              create: (context) => getIt<ChangePasswordCubit>(),
              child: child,
            ),
      ),
      pageBuilder:
          ({required Widget child, required String key}) =>
              SlideTransitionPage(child: child, key: key),
    ),

    AnimatedScreenItem(
      screenItem: ScreenItem(
        screen: Routes.editProfile.value,
        path: Routes.editProfile.key,
        blocProvider:
            (child) => BlocProvider(
              create: (context) => getIt<EditProfileCubit>(),
              child: child,
            ),
      ),
      pageBuilder:
          ({required Widget child, required String key}) =>
              SlideTransitionPage(child: child, key: key),
    ),
  ];

  static final List<ScreenItem> navigationScreens = [
    ScreenItem(
      screen: Routes.homeScreen.value,
      path: Routes.homeScreen.key,

      icon: 'assets/icons/home.svg',
      activeIcon: 'assets/icons/active/home.svg',
      darkActiveIcon: 'assets/icons/active/Dhome.svg',
    ),
    ScreenItem(
      screen: Routes.mapScreen.value,
      path: Routes.mapScreen.key,
      icon: 'assets/icons/map.svg',
      blocProvider: (child) {
        return BlocProvider(
          create: (context) => getIt<IssuesMapCubit>(),
          child: child,
        );
      },
      activeIcon: 'assets/icons/active/map.svg',
      darkActiveIcon: 'assets/icons/active/Dmap.svg',
    ),
    ScreenItem(
      screen: Routes.userReportsScreen.value,
      path: Routes.userReportsScreen.key,
      icon: 'assets/icons/user_reports.svg',
      activeIcon: 'assets/icons/active/user_reports.svg',
      darkActiveIcon: 'assets/icons/active/Duser_reports.svg',
      blocProvider: (child) {
        return BlocProvider(
          create: (context) => getIt<IssueDetailsCubit>(),
          child: child,
        );
      },
    ),
    ScreenItem(
      screen: Routes.settingsScreen.value,
      path: Routes.settingsScreen.key,
      icon: 'assets/icons/settings.svg',
      activeIcon: 'assets/icons/active/settings.svg',
      darkActiveIcon: 'assets/icons/active/Dsettings.svg',
    ),
  ];

  static final ScreenItem fab = ScreenItem(
    screen: Routes.submitReportScreen.value,
    path: Routes.submitReportScreen.key,
    blocProvider: (child) {
      return BlocProvider(
        create: (context) => getIt<SubmitReportCubit>(),
        child: child,
      );
    },
    icon: 'assets/icons/add_report.svg',
  );
}
