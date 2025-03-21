import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snapnfix/core/theming/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsAndPrivacyPolicy extends StatelessWidget {
  const TermsAndPrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return RichText(
      text: TextSpan(
        text: localization.agreeWith,
        style: TextStyles.font14Normal(TextColor.secondaryColor),
        children: [
          TextSpan(
            text: localization.termsOfServices,
            style: TextStyles.font14Medium(TextColor.primaryColor),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    /// Terms of services screen
                  },
          ),
          TextSpan(
            text: localization.and,
            style: TextStyles.font14Normal(TextColor.secondaryColor),
          ),
          TextSpan(
            text: localization.privacyPolicy,
            style: TextStyles.font14Medium(TextColor.primaryColor),
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
