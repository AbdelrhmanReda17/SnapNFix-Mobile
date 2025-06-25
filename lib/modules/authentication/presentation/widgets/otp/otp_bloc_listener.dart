import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_alert_component/alert_type.dart';
import 'package:snapnfix/core/base_components/base_alert_component/base_alert.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';
import 'package:snapnfix/core/utils/mixins/listener_mixin.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class OtpBlocListener extends StatelessWidget with ListenerMixin {
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
            handleSuccess(
              context,
              showSuccessMessage: true,
              successMessage: localization.otpSentSuccessfully,
            );
          },
          successAndRequiresPasswordReset: () {
            handleSuccess(
              context,
              showSuccessMessage: true,
              successMessage:
                  localization.otpVerifiedSuccessfullyAndPasswordResetRequired,
              navigationRoute: Routes.resetPassword,
            );
          },
          successAndRequiresProfileCompletion: (phoneNumber, password) {
            handleSuccess(
              context,
              showSuccessMessage: true,

              successMessage:
                  localization
                      .otpVerifiedSuccessfullyAndProfileCompletionRequired,
              navigationRoute: Routes.completeProfile,
              navigationExtra: {
                'phoneNumber': phoneNumber,
                'password': password,
              },
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
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: colorScheme.error,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: localization.dismiss,
          textColor: colorScheme.onPrimary,
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
