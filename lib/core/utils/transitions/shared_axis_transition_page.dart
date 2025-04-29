import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SharedAxisTransitionPage extends Page {
  final Widget child;
  final SharedAxisTransitionType transitionType;

  const SharedAxisTransitionPage({
    required this.child,
    this.transitionType = SharedAxisTransitionType.horizontal,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: transitionType,
          child: child,
        );
      },
    );
  }
}