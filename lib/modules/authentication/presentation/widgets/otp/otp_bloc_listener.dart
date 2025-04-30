import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/mixins/authentication_listener_mixin.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class OtpBlocListener extends StatelessWidget with AuthenticationListenerMixin {
  const OtpBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        state.maybeWhen(
          initial: (canResend, remainingTime, registrationExpiryTime) {
            if (registrationExpiryTime == 120) {
              // 2 minutes warning
              _showExpiryWarning(context);
            }
          },
          success: () {
            handleSuccess(
              context,
              message:
                  "OTP verified successfully , you can now login to your account",
              route: Routes.homeScreen.key,
            );
          },
          requiresPasswordReset: () {
            handleSuccess(
              context,
              message:
                  "OTP verified successfully , you can now reset your password",
              route: Routes.resetPasswordScreen.key,
            );
          },
          expired: () {
            baseDialog(
              context: context,
              title: "OTP Expired",
              message: "your otp has expired , please request a new one",
              alertType: AlertType.info,
              confirmText: "Understood",
              onConfirm: () {
                context.pop();
              },
              showCancelButton: false,
            );
          },
          registrationExpired: () {
            baseDialog(
              context: context,
              title: "Registration Expired",
              message: "Your registration has expired. Please sign up again.",
              alertType: AlertType.info,
              confirmText: "Understood",
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
          error: (error) => handleError(context, error),
          orElse: () {},
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showExpiryWarning(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        backgroundColor: colorScheme.error.withOpacity(0.1),
        content: Text(
          'Warning: Only 2 minutes remaining to complete verification!',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.error,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text('Dismiss'),
          ),
        ],
      ),
    );
  }
}
