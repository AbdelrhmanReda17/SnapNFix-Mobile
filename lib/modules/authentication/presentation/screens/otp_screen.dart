import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/authentication_content.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/otp/otp_bloc_listener.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/otp/otp_footer.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/otp/otp_form.dart';

class OtpScreen extends StatelessWidget {
  final String? emailOrPhoneNumber;
  final String? password;
  final OtpPurpose? purpose;
  final bool isRegister;

  const OtpScreen({
    super.key,
    this.emailOrPhoneNumber,
    this.password,
    this.purpose,
    this.isRegister = false,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return AuthenticationContent(
      title: localization.verificationCodeTitle,
      subtitle: '${localization.pleaseEnterCode} $emailOrPhoneNumber',
      buttonText: localization.verify,
      form: OtpForm(
        onSubmit: (otpCode) {
          context.read<OtpCubit>().otpCode = otpCode;
          context.read<OtpCubit>().updateOtpCode(
            otpCode,
            purpose!,
            phoneNumber: emailOrPhoneNumber,
            password: password,
          );
        },
      ),
      blocListener: const OtpBlocListener(),
      onSubmit: () {
        context.read<OtpCubit>().verifyOtp(
          phoneNumber: emailOrPhoneNumber,
          password: password,
          purpose: purpose!,
        );
      },
      showSocial: false,
      showTerms: false,
      showBackButton: true,
      additionalContent: [OtpFooter(purpose: purpose!)],
    );
  }
}
