import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'
    show
        GoRoute,
        GoRouter,
        GoRouterState,
        ShellRoute,
        StatefulNavigationShellState,
        StatefulShellBranch,
        StatefulShellRoute;
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/onboarding/screens/onboarding_screen.dart';
import 'package:snapnfix/presentation/navigation/configuration/route_configuration.dart';
import 'package:snapnfix/presentation/navigation/router_observer.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';
import 'package:snapnfix/presentation/navigation/routes/application_routes.dart';
import 'package:snapnfix/presentation/navigation/routes/authentication_routes.dart';
import 'package:snapnfix/presentation/navigation/shells/application_shell.dart';
import 'package:snapnfix/presentation/navigation/shells/authentication_shell.dart';

class RouterConfiguration {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _authNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<StatefulNavigationShellState>();

  static GoRouter get router => _router;
  static ApplicationConfigurations appConfigurations =
      getIt<ApplicationConfigurations>();

  static final _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    refreshListenable: appConfigurations,
    initialLocation: _getInitialLocation(),
    observers: [RouterObserver()],
    routes: [
      GoRoute(
        path: Routes.onBoarding,
        name: Routes.onBoarding,
        builder: (context, state) => OnboardingScreen(),
      ),
      ShellRoute(
        navigatorKey: _authNavigatorKey,
        builder: (context, state, child) {
          return AuthenticationShell(child: child);
        },
        routes: _buildGoRoutes(AuthenticationRoutes.routes),
      ),
      StatefulShellRoute.indexedStack(
        key: _shellNavigatorKey,
        builder: (context, state, navigationShell) {
          return ApplicationShell(navigationShell: navigationShell);
        },
        branches: [
          ...ApplicationRoutes.routes.map(
            (route) => StatefulShellBranch(routes: _buildGoRoutes([route])),
          ),
        ],
      ),
      ..._buildGoRoutes([ApplicationRoutes.issueDetailsRoute]),
    ],
    redirect: (context, state) => _handleRedirect(context, state),
  );

  static List<GoRoute> _buildGoRoutes(List<RouteConfiguration> routes) {
    return routes.map((route) {
      return GoRoute(
        path: route.path,
        name: route.name,
        redirect: (context, state) async {
          if (!route.validateParameters(state)) {
            return '/error?message=invalid_parameters';
          }
          return await route.guard(context, state);
        },
        pageBuilder: (context, state) {
          return route.buildPage(context, state);
        },
        routes: _buildGoRoutes(route.children),
      );
    }).toList();
  }

  static String _getInitialLocation() {
    if (appConfigurations.isAuthenticated) {
      return Routes.home;
    } else if (appConfigurations.hasViewedOnboarding) {
      return Routes.login;
    } else {
      return Routes.onBoarding;
    }
  }

  static String? _handleRedirect(BuildContext context, GoRouterState state) {
    if (!appConfigurations.isAuthenticated &&
        !state.uri.toString().contains(Routes.login) &&
        !state.uri.toString().contains(Routes.register) &&
        !state.uri.toString().contains(Routes.onBoarding) &&
        !state.uri.toString().contains(Routes.forgotPassword) &&
        !state.uri.toString().contains(Routes.resetPassword) &&
        !state.uri.toString().contains(Routes.completeProfile) &&
        !state.uri.toString().contains(Routes.otp)) {
      return Routes.login;
    }
    if (appConfigurations.isAuthenticated &&
        (state.uri.toString().contains(Routes.login) ||
            state.uri.toString().contains(Routes.onBoarding) ||
            state.uri.toString().contains(Routes.register))) {
      return Routes.home;
    }
    return null;
  }
}
