import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class TermsAndPrivacyPolicy extends StatelessWidget {
  const TermsAndPrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final localization = AppLocalizations.of(context)!;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: localization.agreeWith,
        style: textStyles.bodySmall?.copyWith(color: colorScheme.secondary),
        children: [
          TextSpan(
            text: localization.termsOfServices,
            style: textStyles.bodySmall?.copyWith(color: colorScheme.primary),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    context.push(Routes.termsAndConditions);
                  },
          ),
          TextSpan(
            text: localization.and,
            style: textStyles.bodySmall?.copyWith(
              color: colorScheme.secondary,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: localization.privacyPolicy,
            style: textStyles.bodySmall?.copyWith(color: colorScheme.primary),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    /// Privacy Policy Screen
                  },
          ),
        ],
      ),
    );
  }
}
