import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterObserver extends NavigatorObserver {
  bool _shouldLogRoute(Route<dynamic>? route) {
    if (route == null) return false;
    // Skip dialog routes
    if (route is DialogRoute) return false;
    // Skip popup routes
    if (route is PopupRoute) return false;
    return true;
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (!_shouldLogRoute(route)) return;

    final currentLocation = _getLocation(route);
    final previousLocation = _getLocation(previousRoute);

    debugPrint('Navigation PUSH: $currentLocation from $previousLocation');
    _logNavigationEvent(
      'PUSH',
      currentLocation,
      previousLocation,
      route.settings.arguments,
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (!_shouldLogRoute(route)) return;

    final currentLocation = _getLocation(route);
    final previousLocation = _getLocation(previousRoute);

    debugPrint('Navigation POP: $currentLocation to $previousLocation');
    _logNavigationEvent(
      'POP',
      currentLocation,
      previousLocation,
      route.settings.arguments,
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final newLocation = _getLocation(newRoute);
    final oldLocation = _getLocation(oldRoute);

    debugPrint('Navigation REPLACE: $oldLocation with $newLocation');
    _logNavigationEvent(
      'REPLACE',
      newLocation,
      oldLocation,
      newRoute?.settings.arguments,
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('Navigation REMOVE: ${_getLocation(route)}');
    // No logging for REMOVE as per the new implementation
  }

  String _getLocation(Route<dynamic>? route) {
    if (route == null) return 'No Route';

    // Get location from GoRouterState if available
    final routeSettings = route.settings;
    if (routeSettings is Page) {
      final state = routeSettings.arguments;
      if (state is GoRouterState) {
        return state.uri.toString();
      }
    }

    // Try to get route name
    if (routeSettings.name?.startsWith('/') ?? false) {
      return routeSettings.name!;
    }

    // Fallback to route settings
    return routeSettings.name ??
        routeSettings.arguments?.toString() ??
        route.toString();
  }

  void _logNavigationEvent(
    String type,
    String currentLocation,
    String previousLocation,
    Object? arguments,
  ) {
    final timestamp = DateTime.now().toIso8601String();
    final Map<String, dynamic> eventData = {
      'event_type': type,
      'current_location': currentLocation,
      'previous_location': previousLocation,
      'arguments': arguments,
      'timestamp': timestamp,
    };

    debugPrint('Navigation Event: $eventData');
  }

  static bool canPopRoute(BuildContext context) {
    final NavigatorState? navigator = Navigator.maybeOf(context);
    return navigator != null && navigator.canPop();
  }

  static bool isFirstRoute(BuildContext context) {
    final GoRouter router = GoRouter.of(context);
    return router.routerDelegate.currentConfiguration.uri.hasAbsolutePath &&
        router.routerDelegate.currentConfiguration.uri.pathSegments.isEmpty;
  }

  static bool isInAuthShell(BuildContext context) {
    final router = GoRouter.of(context);
    final location = router.routerDelegate.currentConfiguration.uri.toString();
    return location.startsWith('/auth');
  }

  static bool isInAppShell(BuildContext context) {
    final router = GoRouter.of(context);
    final location = router.routerDelegate.currentConfiguration.uri.toString();
    return location.startsWith('/app');
  }
}
