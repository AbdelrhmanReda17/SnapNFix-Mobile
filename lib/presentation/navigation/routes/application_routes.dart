import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/issues/presentation/cubits/issue_details_cubit.dart';
import 'package:snapnfix/modules/issues/presentation/cubits/issues_map_cubit.dart';
import 'package:snapnfix/modules/issues/presentation/screens/issue_details_screen.dart';
import 'package:snapnfix/modules/issues/presentation/screens/issue_map_screen.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/report_review_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_report_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/screens/submit_report_screen.dart';
import 'package:snapnfix/modules/reports/presentation/screens/user_reports_screen.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/change_password_cubit.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/edit_profile_cubit.dart';
import 'package:snapnfix/modules/settings/presentation/screens/about_screen.dart';
import 'package:snapnfix/modules/settings/presentation/screens/change_password.dart';
import 'package:snapnfix/modules/settings/presentation/screens/edit_profile.dart';
import 'package:snapnfix/modules/settings/presentation/screens/privacy_policy_screen.dart';
import 'package:snapnfix/modules/settings/presentation/screens/settings_dart.dart';
import 'package:snapnfix/modules/settings/presentation/screens/support_screen.dart';
import 'package:snapnfix/modules/settings/presentation/screens/terms_conditions_screen.dart';
import 'package:snapnfix/presentation/navigation/configuration/route_configuration.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';
import 'package:snapnfix/presentation/screens/home_screen.dart';

class ApplicationRoutes {
  static final homeRoute = RouteConfiguration(
    path: Routes.home,
    name: 'home',
    builder: (context, state) => const HomeScreen(),
  );

  static final mapRoute = RouteConfiguration(
    path: Routes.map,
    name: 'map',
    builder:
        (context, state) => BlocProvider<IssuesMapCubit>(
          create: (context) => getIt<IssuesMapCubit>(),
          child: const IssueMapScreen(),
        ),
  );

  static final submitReportRoute = RouteConfiguration(
    path: Routes.submitReport,
    name: 'submitReport',
    builder:
        (context, state) => BlocProvider<SubmitReportCubit>(
          create: (context) => getIt<SubmitReportCubit>(),
          child: const SubmitReportScreen(),
        ),
  );

  static final reportsRoute = RouteConfiguration(
    path: Routes.userReports,
    name: 'reports',
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<ReportReviewCubit>(),
          child: const UserReportsScreen(),
        ),
  );

  static final issueDetailsRoute = RouteConfiguration(
    path: Routes.issueDetails,
    name: 'issueDetailsScreen',
    builder: (context, state) {
      final issueId = state.extra as String;
      return BlocProvider<IssueDetailsCubit>(
        create: (context) => getIt<IssueDetailsCubit>(),
        child: IssueDetailsScreen(issueId: issueId),
      );
    },
  );
  
  static final settingsRoute = RouteConfiguration(
    path: Routes.settings,
    name: 'settings',
    builder: (context, state) => const SettingsScreen(),
    children: [
      RouteConfiguration(
        path: 'edit-profile',
        name: 'edit-profile',
        transitionType: PageTransitionType.slide,
        builder:
            (context, state) => BlocProvider<EditProfileCubit>(
              create: (context) => getIt<EditProfileCubit>(),
              child: const EditProfile(),
            ),
      ),
      RouteConfiguration(
        path: 'change-password',
        name: 'change-password',
        transitionType: PageTransitionType.slide,
        builder:
            (context, state) => BlocProvider<ChangePasswordCubit>(
              create: (context) => getIt<ChangePasswordCubit>(),
              child: const ChangePassword(),
            ),
      ),
      RouteConfiguration(
        path: "support",
        name: 'support',
        transitionType: PageTransitionType.slide,
        builder: (context, state) => const SupportScreen(),
      ),
      RouteConfiguration(
        path: 'about',
        name: 'about',
        transitionType: PageTransitionType.slide,
        builder: (context, state) => const AboutScreen(),
      ),
      RouteConfiguration(
        path: 'terms-and-conditions',
        name: 'terms-and-conditions',
        transitionType: PageTransitionType.slide,
        builder: (context, state) => const TermsConditionsScreen(),
      ),
      RouteConfiguration(
        path: 'privacy-policy',
        name: 'privacy-policy',
        transitionType: PageTransitionType.slide,
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
    ],
  );

  static final List<RouteConfiguration> routes = [
    homeRoute,
    mapRoute,
    reportsRoute,
    settingsRoute,
    submitReportRoute,
  ];
}

