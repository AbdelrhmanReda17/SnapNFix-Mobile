import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/application_screens.dart';
import 'package:snapnfix/core/application_configurations.dart';
import 'package:snapnfix/core/application_components/application_scaffold.dart';
import 'package:snapnfix/core/routes.dart';

class ApplicationRouter {
  final GoRouter router = GoRouter(
    initialLocation:
        ApplicationConfigurations.userToken.isNotEmpty
            ? Routes.homeScreen.key
            : ApplicationConfigurations.hasViewedOnboarding
            ? Routes.loginScreen.key
            : Routes.onBoardingScreen.key,
    routes: [
      for (var screen in ApplicationScreens.screens)
        GoRoute(
          path: screen.path,
          builder: (context, state) => screen.wrappedWidget,
        ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BaseScreen(navigationShell: navigationShell);
        },
        branches: [
          for (var screen in ApplicationScreens.navigationScreens)
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: screen.path,
                  builder: (context, state) => screen.wrappedWidget,
                ),
              ],
            ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ApplicationScreens.fab.path,
                builder:
                    (context, state) => ApplicationScreens.fab.wrappedWidget,
              ),
            ],
          ),

          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       path: Routes.homeScreen.key,
          //       builder: (context, state) => Routes.homeScreen.value,
          //     ),
          //   ],
          // ),
          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       path: Routes.mapScreen.key,
          //       builder: (context, state) => Routes.mapScreen.value,
          //     ),
          //   ],
          // ),
          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       path: Routes.addReportScreen.key,
          //       builder: (context, state) => Routes.addReportScreen.value,
          //     ),
          //   ],
          // ),
          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       path: Routes.userReportsScreen.key,
          //       builder: (context, state) => Routes.userReportsScreen.value,
          //     ),
          //   ],
          // ),
          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       path: Routes.settingsScreen.key,
          //       builder: (context, state) => Routes.settingsScreen.value,
          //     ),
          //   ],
          // ),
        ],
      ),
    ],
  );
}
