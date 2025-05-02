import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum PageTransitionType { fade, slide, scale, slideUp, none }

class RouteConfiguration {
  final String path;
  final String? name;
  final Widget Function(BuildContext context, GoRouterState state) builder;
  final List<RouteConfiguration> children;
  final PageTransitionType transitionType;

  const RouteConfiguration({
    required this.path,
    this.name,
    required this.builder,
    this.children = const [],
    this.transitionType = PageTransitionType.fade,
  });

  Page<dynamic> buildPage(BuildContext context, GoRouterState state) {
    if (transitionType == PageTransitionType.none) {
      return NoTransitionPage(
        key: state.pageKey,
        child: builder(context, state),
      );
    }

    return CustomTransitionPage(
      key: state.pageKey,
      child: builder(context, state),
      transitionsBuilder: _buildTransition,
    );
  }

  Widget _buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    switch (transitionType) {
      case PageTransitionType.fade:
        return FadeTransition(opacity: animation, child: child);
      case PageTransitionType.slide:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case PageTransitionType.slideUp:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case PageTransitionType.scale:
        return ScaleTransition(scale: animation, child: child);
      case PageTransitionType.none:
        return child;
    }
  }

  Future<String?> guard(BuildContext context, GoRouterState state) =>
      Future.value(null);

  bool validateParameters(GoRouterState state) => true;
}
