import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
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
              _showExpiryWarning(context);
            }
          },
          resendSuccess: () {
            handleSuccess(context, message: "OTP resent successfully");
          },
          successAndRequiresPasswordReset: () {
            handleSuccess(
              context,
              message:
                  "OTP verified successfully , you can now reset your password",
              route: Routes.resetPassword,
            );
          },
          successAndRequiresProfileCompletion: (phoneNumber, password) {
            handleSuccess(
              context,
              message:
                  "OTP verified successfully , you can now complete your profile",
              route: Routes.completeProfile,
              extra: {'phoneNumber': phoneNumber, 'password': password},
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
          error: (error) {
            handleError(context, error);
            // getIt<OtpCubit>().restoreInitialStateWithTimers();
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Warning: Only 2 minutes remaining to complete verification!',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: colorScheme.error,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Dismiss',
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
