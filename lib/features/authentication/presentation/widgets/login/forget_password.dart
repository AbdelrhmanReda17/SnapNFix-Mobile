import 'package:flutter/material.dart';
import 'package:snapnfix/core/theming/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        /// Forget Password Screen
      },
      child: Text(
        localization.forgetPassword,
        style: TextStyles.font14Normal(TextColor.primaryColor),
      ),
    );
  }
}
