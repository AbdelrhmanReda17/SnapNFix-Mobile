import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/presentation/navigation/application_screens.dart';
import 'package:snapnfix/presentation/components/application_scaffold.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class ApplicationRouter {
  final ApplicationConfigurations appConfigurations;
  late final GoRouter router;

  ApplicationRouter({required this.appConfigurations}) {
    router = _createRouter();
  }

  GoRouter _createRouter() {
    return GoRouter(
      refreshListenable: appConfigurations,
      initialLocation: _getInitialLocation(),
      routes: [
        for (var animatedScreen in ApplicationScreens.animatedScreens)
          GoRoute(
            path: animatedScreen.screenItem.path,
            pageBuilder:
                (context, state) => animatedScreen.pageBuilder(
                  child: animatedScreen.screenItem.wrappedWidget,
                  key: state.matchedLocation,
                ),
          ),

        // Handle all other standard screens normally
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
          ],
        ),
      ],
      redirect: (context, state) {
        if (!appConfigurations.isAuthenticated &&
            !state.uri.toString().contains(Routes.loginScreen.key) &&
            !state.uri.toString().contains(Routes.registerScreen.key) &&
            !state.uri.toString().contains(Routes.onBoardingScreen.key) &&
            !state.uri.toString().contains(Routes.forgotPasswordScreen.key) &&
            !state.uri.toString().contains(Routes.resetPasswordScreen.key) &&
            !state.uri.toString().contains(Routes.otpScreen.key)) {
          return Routes.loginScreen.key;
        }
        if (appConfigurations.isAuthenticated &&
            (state.uri.toString().contains(Routes.loginScreen.key) ||
                state.uri.toString().contains(Routes.onBoardingScreen.key) ||
                state.uri.toString().contains(Routes.registerScreen.key))) {
          return Routes.homeScreen.key;
        }
        return null;
      },
    );
  }

  String _getInitialLocation() {
    if (appConfigurations.isAuthenticated) {
      return Routes.homeScreen.key;
    } else if (appConfigurations.hasViewedOnboarding) {
      return Routes.loginScreen.key;
    } else {
      return Routes.onBoardingScreen.key;
    }
  }
}
