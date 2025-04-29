import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class OtpBlocListener extends StatelessWidget {
  const OtpBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (session) {
            context.go(Routes.homeScreen.key);
          },
          requiresProfile: () {
            context.pop();
            context.pushReplacement(Routes.completeProfileScreen.key);
          },
          requiresPasswordReset: () {
            context.pop();
            context.pushReplacement(Routes.resetPasswordScreen.key);
          },
          resendSuccess: () {
            context.pop();
            baseDialog(
              context: context,
              title: 'Code Resent',
              message: 'Verification code has been resent successfully.',
              alertType: AlertType.success,
              confirmText: 'OK',
              onConfirm: () {},
              showCancelButton: false,
            );
          },
          error: (error) {
            setupErrorState(context, error);
          },
          loading: () {
            showLoadingDialog(context);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, ApiErrorModel error) {
    context.pop();
    baseDialog(
      context: context,
      title: 'Verification Error',
      message: error.getAllErrorMessages(),
      alertType: AlertType.error,
      confirmText: 'Got it',
      onConfirm: () {},
      showCancelButton: false,
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
    );
  }
}
