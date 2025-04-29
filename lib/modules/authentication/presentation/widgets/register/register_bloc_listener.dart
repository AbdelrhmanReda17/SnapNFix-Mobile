import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/register/register_cubit.dart';
import '../../../../../../presentation/navigation/routes.dart';

class RegisterBlocListener extends StatelessWidget {
  const RegisterBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (session) {
            context.go(Routes.homeScreen.key);
          },
          requiresVerification: () {
            context.pop();
            context.push(Routes.otpScreen.key);
          },
          requiresProfile: () {
            context.pop();
            context.push(Routes.completeProfileScreen.key);
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
      title: 'Error',
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
