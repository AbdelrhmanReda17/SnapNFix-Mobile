import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/mixins/authentication_listener_mixin.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class OtpBlocListener extends StatelessWidget with AuthenticationListenerMixin {
  const OtpBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        state.maybeWhen(
          initial: (canResend, remainingTime, registrationExpiryTime) {
            if (registrationExpiryTime == 120) {
              _showExpiryWarning(context);
            }
          },
          resendSuccess: () {
            handleSuccess(context, message: localization.otpSentSuccessfully);
          },
          successAndRequiresPasswordReset: () {
            handleSuccess(
              context,
              message:
                  localization.otpVerifiedSuccessfullyAndPasswordResetRequired,
              route: Routes.resetPassword,
            );
          },
          successAndRequiresProfileCompletion: (phoneNumber, password) {
            handleSuccess(
              context,
              message:
                  localization.otpVerifiedSuccessfullyAndProfileCompletionRequired,
              route: Routes.completeProfile,
              extra: {'phoneNumber': phoneNumber, 'password': password},
            );
          },
          registrationExpired: () {
            baseDialog(
              context: context,
              title: localization.registerationExpiredTitle,
              message: localization.registerationExpiredMessage,
              alertType: AlertType.info,
              confirmText: localization.understood,
              onConfirm: () {
                context.pop();
              },
              showCancelButton: false,
              onCancel: () {
                context.pop();
              },
            );
          },
          loading: () => showLoadingDialog(context),
          error: (error) {
            handleError(context, error);
          },
          orElse: () {},
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showExpiryWarning(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localization = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          localization.timeWarningMessageText,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: colorScheme.error,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: localization.dismiss,
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
