import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/forget_password/forgot_password_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/authentication_content.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/forget_password/forget_password_bloc_listener.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/forget_password/forget_password_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return AuthenticationContent(
      title: localization.forgotPasswordTitle,
      subtitle: localization.forgotPasswordSubtitle,
      buttonText: localization.sendCode,
      footerQuestion: localization.forgetPasswordFooterQuestion,
      footerAction: localization.contactUs,
      onFooterTap: () {},
      form: const ForgetPasswordForm(),
      blocListener: const ForgetPasswordBlocListener(),
      onSubmit:
          () async =>
              await context.read<ForgotPasswordCubit>().requestPasswordReset(),
      showSocial: false,
      showTerms: false,
      showBackButton: true,
    );
  }
}
