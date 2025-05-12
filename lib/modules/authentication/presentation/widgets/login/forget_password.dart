import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        context.push(Routes.forgotPassword);
      },
      child: Text(
        localization.forgetPassword,
        style: textStyles.bodyMedium!.copyWith(color: colorScheme.primary),
      ),
    );
  }
}
