import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/authentication_footer.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/authentication_social.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/register/terms_and_privacy_policy.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/authentication_header.dart';
import 'package:snapnfix/presentation/components/application_system_ui_overlay.dart';

class AuthenticationScreen<T extends Cubit<dynamic>> extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final String? footerQuestion;
  final String? footerAction;
  final VoidCallback? onFooterTap;
  final Widget form;
  final Widget blocListener;
  final VoidCallback onSubmit;
  final bool showTerms;
  final bool showSocial;
  final bool showBackButton;
  final List<Widget>? additionalContent;
  final bool footerEnabled;
  final String? footerTimerText;

  const AuthenticationScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.form,
    required this.blocListener,
    required this.onSubmit,
    this.footerQuestion,
    this.footerAction,
    this.onFooterTap,
    this.showTerms = false,
    this.showSocial = true,
    this.showBackButton = false,
    this.additionalContent,
    this.footerEnabled = true,
    this.footerTimerText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final appConfigs = ApplicationConfigurations.instance;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ApplicationSystemUIOverlay.getDefaultStyle(appConfigs.isDarkMode),
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              AuthenticationHeader(
                showBackButton: showBackButton,
                title: title,
                subtitle: subtitle,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: animation.drive(
                          Tween<Offset>(
                            begin: const Offset(0, 0.1),
                            end: Offset.zero,
                          ),
                        ),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    key: ValueKey('content_$title $subtitle'),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(5),
                      form,
                      verticalSpace(24),
                      if (additionalContent != null) ...additionalContent!,
                      BaseButton(
                        text: buttonText,
                        onPressed: onSubmit,
                        backgroundColor: colorScheme.primary,
                        textStyle: textStyles.bodyLarge!.copyWith(
                          color: colorScheme.surface,
                        ),
                      ),
                      if (showTerms) ...[
                        verticalSpace(20),
                        const TermsAndPrivacyPolicy(),
                      ],
                      if (showSocial) ...[
                        verticalSpace(20),
                        const AuthenticationSocial(),
                      ],
                      if (onFooterTap != null &&
                          footerQuestion != null &&
                          footerAction != null)
                        Padding(
                          padding: EdgeInsets.only(top: 20.h, bottom: 16.h),
                          child: AuthenticationFooter(
                            questionText: footerQuestion!,
                            actionText: footerAction!,
                            onTap: onFooterTap!,
                            isEnabled: footerEnabled,
                            timerText: footerTimerText,
                          ),
                        ),
                      blocListener,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
