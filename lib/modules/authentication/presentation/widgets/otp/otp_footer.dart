import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/authentication_footer.dart';

class OtpFooter extends StatelessWidget {
  final bool isRegister;

  const OtpFooter({super.key, required this.isRegister});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return BlocBuilder<OtpCubit, OtpState>(
      buildWhen:
          (previous, current) => current.maybeWhen(
            initial: (_, __, ___) => true,
            orElse: () => false,
          ),
      builder: (context, state) {
        bool canResend = false;
        String? timerText;

        state.maybeWhen(
          initial: (enableResend, remainingTime, _) {
            canResend = enableResend;
            if (!enableResend) {
              timerText = '${localization.resendCode} (${remainingTime}s)';
            }
          },
          orElse: () {},
        );

        return AuthenticationFooter(
          questionText: localization.didnotReceiveCode,
          actionText: localization.resendCode,
          onTap: () {
            context.read<OtpCubit>().resendOtp(isRegister: isRegister);
          },
          isEnabled: canResend,
          timerText: timerText,
        );
      },
    );
  }
}
