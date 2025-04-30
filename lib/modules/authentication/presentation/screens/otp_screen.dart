import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/screens/authentication_screen.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/otp/otp_bloc_listener.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/otp/otp_form.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/registration_expiry_timer.dart';

class OtpScreen extends StatelessWidget {
  final String? emailOrPhoneNumber;
  final String? verificationToken;
  final OtpPurpose? purpose;

  const OtpScreen({
    super.key,
    this.emailOrPhoneNumber,
    this.verificationToken,
    this.purpose,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'OtpScreen: emailOrPhoneNumber: $emailOrPhoneNumber, verificationToken: $verificationToken, purpose: $purpose',
    );
    final localization = AppLocalizations.of(context)!;
    final subtitle = '${localization.pleaseEnterCode} $emailOrPhoneNumber';

    return BlocBuilder<OtpCubit, OtpState>(
      buildWhen:
          (previous, current) =>
              current.maybeMap(initial: (_) => true, orElse: () => false),
      builder: (context, state) {
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
          form: const OtpForm(),
          blocListener: const OtpBlocListener(),
          onSubmit: () {
            context.read<OtpCubit>().verifyOtp(
              emailOrPhoneNumber!,
              verificationToken!,
              purpose!,
            );
          },
          showSocial: false,
          showTerms: false,
          footerEnabled: state.maybeMap(
            initial: (s) => s.canResend,
            orElse: () => false,
          ),
          footerTimerText: state.maybeMap(
            initial:
                (s) =>
                    !s.canResend
                        ? '${localization.resendCode} (${s.remainingTime}s)'
                        : null,
            orElse: () => null,
          ),
          additionalContent: [
            if (purpose == OtpPurpose.registration)
              state.maybeMap(
                initial:
                    (initial) => RegistrationExpiryTimer(
                      remainingTime: initial.registrationExpiryTime,
                    ),
                orElse: () => const SizedBox.shrink(),
              ),
            SizedBox(height: 16.h),
          ],
        );
      },
    );
  }
}
