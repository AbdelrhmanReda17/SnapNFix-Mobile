import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class ResetPasswordBlocListener extends StatelessWidget {
  const ResetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (session) {
            context.pop();
            baseDialog(
              context: context,
              title: 'Success',
              message: 'Password reset successfully',
              alertType: AlertType.success,
              confirmText: 'Got it',
              onConfirm: () {
                context.pop();
                context.go(Routes.loginScreen.key);
              },
              showCancelButton: false,
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
