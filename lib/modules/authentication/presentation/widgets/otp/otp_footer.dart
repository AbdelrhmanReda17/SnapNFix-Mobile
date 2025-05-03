import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/authentication_footer.dart';

class OtpFooter extends StatelessWidget {
  final OtpPurpose purpose;

  const OtpFooter({super.key, required this.purpose});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final cubit = context.read<OtpCubit>();
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        String? timerText;
        final remainingTime = cubit.remainingTime;
        final canResend = cubit.canResend;
        if (remainingTime > 0) {
          timerText = '${localization.resendCode} (${remainingTime}s)';
        } else {
          timerText = localization.resendCode;
        }

        return AuthenticationFooter(
          questionText: localization.didnotReceiveCode,
          actionText: localization.resendCode,
          onTap: canResend ? () => cubit.resendOtp(purpose: purpose) : null,
          isEnabled: canResend,
          timerText: timerText,
        );
      },
    );
  }
}
