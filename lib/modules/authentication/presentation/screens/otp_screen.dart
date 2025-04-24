import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/screens/auhentication_screen.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/otp/otp_bloc_listener.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/otp/otp_form.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return AuthenticationScreen<OtpCubit>(
      title: localization.verificationCodeTitle,
      subtitle: localization.pleaseEnterCode,
      buttonText: localization.verify,
      footerQuestion: localization.didnotReceiveCode,
      footerAction: localization.resendCode,
      onFooterTap: () {
        context.read<OtpCubit>().resendOtp();
      },
      form: OtpForm(),
      blocListener: const OtpBlocListener(),
      onSubmit: () {
        context.read<OtpCubit>().verifyOtp();
      },
      isOtp: true,
    );
  }
}
