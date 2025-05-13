import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/utils/extensions/navigation.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/authentication_footer.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/authentication_social.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/register/terms_and_privacy_policy.dart';
import 'package:snapnfix/presentation/navigation/router_observer.dart';

class AuthenticationContent extends StatelessWidget {
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
  final List<Widget>? additionalContent;
  final bool footerEnabled;
  final String? footerTimerText;
  final Widget? footer;
  final bool showBackButton;

  const AuthenticationContent({
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
    this.additionalContent,
    this.footerEnabled = true,
    this.footerTimerText,
    this.footer,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        if (RouterObserver.canPopRoute(context) && showBackButton)
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 13.h),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.pop();
                },
                color: Theme.of(context).colorScheme.primary,
                iconSize: 30.sp,
              ),
            ),
          ),
        horizontalSpace(45.h),
        Image.asset('assets/images/SnapNFix.png', height: 70.h),
        Text(
          title,
          style: textStyles.headlineLarge?.copyWith(
            color: colorScheme.primary,
            fontSize: 24.sp,
            height: 1.4,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        horizontalSpace(8.h),
        SizedBox(
          width: 280.w,
          height: 40.h,
          child: Text(
            subtitle,
            style: textStyles.bodyMedium?.copyWith(
              color: colorScheme.primary.withAlpha(179),
              fontSize: 14.sp,
              height: 1.4,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        verticalSpace(24),
        form,
        verticalSpace(24),
        if (additionalContent != null) ...[
          ...additionalContent!,
          verticalSpace(24),
        ],
        BaseButton(
          text: buttonText,
          onPressed: onSubmit,
          backgroundColor: colorScheme.primary,
          textStyle: textStyles.bodyLarge!.copyWith(color: colorScheme.surface),
        ),
        if (showTerms) ...[verticalSpace(20), const TermsAndPrivacyPolicy()],
        if (showSocial) ...[verticalSpace(20), const AuthenticationSocial()],
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
        if (footer != null) ...[verticalSpace(20), footer!],
        blocListener,
      ],
    );
  }
}
