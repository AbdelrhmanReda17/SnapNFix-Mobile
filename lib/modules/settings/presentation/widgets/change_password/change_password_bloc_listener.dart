import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/modules/settings/logic/cubit/change_password_cubit.dart';


class ChangePasswordBlocListener extends StatelessWidget {
  const ChangePasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (changePasswordResponse) {
            context.pop();
            baseDialog(
              context: context,
              title: 'Success',
              message: 'Password changed successfully',
              alertType: AlertType.success,
              confirmText: 'Got it',
              onConfirm: () => context.pop(),
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

  void setupErrorState(BuildContext context, String error) {
    context.pop();
    baseDialog(
      context: context,
      title: 'Error',
      message: error,
      alertType: AlertType.error,
      confirmText: 'Got it',
      onConfirm: () {},
      showCancelButton: false,
    );
  }
}
