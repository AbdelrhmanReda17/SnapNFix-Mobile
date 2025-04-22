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
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (verificationResponse) {
            context.go(Routes.homeScreen.key);
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
            showDialog(
              context: context,
              builder: (context) => Center(
                child: CircularProgressIndicator(
                  color: colorScheme.primary,
                ),
              ),
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    context.pop(); // Dismiss the loading dialog
    baseDialog(
      context: context,
      title: 'Verification Error',
      message: apiErrorModel.getAllErrorMessages(),
      alertType: AlertType.error,
      confirmText: 'Got it',
      onConfirm: () {},
      showCancelButton: false,
    );
  }
}