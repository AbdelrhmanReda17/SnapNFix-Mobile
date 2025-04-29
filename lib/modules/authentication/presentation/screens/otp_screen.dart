import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/screens/authentication_screen.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/otp/otp_bloc_listener.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/otp/otp_form.dart';

class OtpScreen extends StatelessWidget {
  final bool isFormForgotPassword;
  final String? emailOrPhoneNumber;

  const OtpScreen({
    super.key,
    this.isFormForgotPassword = false,
    this.emailOrPhoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final subtitle =
        (emailOrPhoneNumber != null && emailOrPhoneNumber!.isNotEmpty)
            ? '${localization.pleaseEnterCode} $emailOrPhoneNumber'
            : localization.pleaseEnterCode;

    return AuthenticationScreen<OtpCubit>(
      showBackButton: true,
      title: localization.verificationCodeTitle,
      subtitle: subtitle,
      buttonText: localization.verify,
      footerQuestion: localization.didnotReceiveCode,
      footerAction: localization.resendCode,
      onFooterTap: () {
        context.read<OtpCubit>().resendOtp();
      },
      form: OtpForm(),
      blocListener: const OtpBlocListener(),
      onSubmit: () {
        context.read<OtpCubit>().verifyOtp(
          isFromForgotPassword: isFormForgotPassword,
        );
      },
      showSocial: false,
      showTerms: false,
      showLogo: !isFormForgotPassword,
    );
  }
}
