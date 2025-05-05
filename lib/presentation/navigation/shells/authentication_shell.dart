import 'package:flutter/material.dart';
import 'package:snapnfix/modules/authentication/presentation/screens/authentication_base_screen.dart';

class AuthenticationShell extends StatelessWidget {
  final Widget child;

  const AuthenticationShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AuthenticationBaseScreen(
      authenticationContent: child,
    );
  }
}
