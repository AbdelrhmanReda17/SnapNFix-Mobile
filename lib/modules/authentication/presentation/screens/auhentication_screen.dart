import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/authentication_footer.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/authentication_social.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/register/terms_and_privacy_policy.dart';
import 'package:snapnfix/presentation/components/application_logo_and_name.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/presentation/components/application_system_ui_overlay.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/core/base_components/base_button.dart';

class AuthenticationScreen<T extends Cubit<void>> extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final String footerQuestion;
  final String footerAction;
  final VoidCallback? onFooterTap;
  final Widget form;
  final Widget blocListener;
  final VoidCallback onSubmit;
  final bool showLogo;
  final bool showTerms;
  final bool showSocial;
  final PreferredSizeWidget? appBar;

  const AuthenticationScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.footerQuestion,
    required this.footerAction,
    required this.form,
    required this.blocListener,
    required this.onSubmit,
    this.onFooterTap,
    this.showLogo = true,
    this.showTerms = false,
    this.showSocial = true,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final appConfigs = ApplicationConfigurations.instance;
    final verticalPadding = showLogo ? 48.h : 16.h;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ApplicationSystemUIOverlay.getDefaultStyle(appConfigs.isDarkMode),
      child: Scaffold(
        
        appBar: appBar,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: verticalPadding,
            ),
            children: [
              if (showLogo) ...[ApplicationLogoAndName(), verticalSpace(15)],
              Text(
                title,
                style: textStyles.headlineLarge?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              Text(
                subtitle,
                style: textStyles.bodyLarge?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              verticalSpace(15),
              form,
              verticalSpace(20),
              BaseButton(
                text: buttonText,
                onPressed: onSubmit,
                textStyle: textStyles.bodyLarge!.copyWith(
                  color: colorScheme.surface,
                ),
              ),
              verticalSpace(20),
              if (showTerms) ...[TermsAndPrivacyPolicy(), verticalSpace(20)],
              if (showSocial) ...[AuthenticationSocial(), verticalSpace(20)],
              if (onFooterTap != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: AuthenticationFooter(
                    questionText: footerQuestion,
                    actionText: footerAction,
                    onTap: onFooterTap!,
                  ),
                ),
              blocListener,
            ],
          ),
        ),
      ),
    );
  }
}
