import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/complete_profile/complete_profile_cubit.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class CompleteProfileBlocListener extends StatelessWidget {
  const CompleteProfileBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showLoadingDialog(context);
          },
          success: (session) {
            context.go(Routes.homeScreen.key);
          },
          error: (error) {
            setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
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
}
