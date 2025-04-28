import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/forget_password/forgot_password_cubit.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class ForgetPasswordBlocListener extends StatelessWidget {
  const ForgetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<ForgotPasswordCubit>();

    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () {
            context.pop();
            final emailOrPhoneNumber = cubit.emailOrPhoneController.text;
            context.push(
              Routes.otpScreen.key,
              extra: {
                'emailOrPhoneNumber': emailOrPhoneNumber,
                'isFormForgotPassword': true,
              },
            );
          },
          error: (error) {
            setupErrorState(context, error);
          },
          loading: () {
            showDialog(
              context: context,
              builder:
                  (context) => Center(
                    child: CircularProgressIndicator(
                      color: colorScheme.primary,
                    ),
                  ),
            );
          },
        );
      },
      child: SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    context.pop();
    baseDialog(
      context: context,
      title: 'Error',
      message: apiErrorModel.getAllErrorMessages(),
      alertType: AlertType.error,
      confirmText: 'Got it',
      onConfirm: () {},
      showCancelButton: false,
    );
  }
}
