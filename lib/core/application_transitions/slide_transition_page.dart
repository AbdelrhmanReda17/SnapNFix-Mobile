import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideTransitionPage extends CustomTransitionPage<void> {
  SlideTransitionPage({required Widget child, required String key})
    : super(
        key: ValueKey(key),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
        opaque: true,
        barrierDismissible: false,
        maintainState: true,
        child: child,
      );
}
