import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/presentation/components/application_system_ui_overlay.dart';

class AuthenticationBaseScreen extends StatelessWidget {
  final Widget authenticationContent;

  const AuthenticationBaseScreen({
    super.key,
    required this.authenticationContent,
  });

  @override
  Widget build(BuildContext context) {
    final appConfigs = getIt<ApplicationConfigurations>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ApplicationSystemUIOverlay.getDefaultStyle(appConfigs.isDarkMode),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Image.asset(
                'assets/images/Pattern.png',
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
              ),
              authenticationContent,
            ],
          ),
        ),
      ),
    );
  }
}
