import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/forget_password/forgot_password_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/mixins/authentication_listener_mixin.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class ForgetPasswordBlocListener extends StatelessWidget
    with AuthenticationListenerMixin {
  const ForgetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();

    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () {
            context.pop();
            context.push(
              Routes.otpScreen.key,
              extra: {
                'emailOrPhoneNumber': cubit.emailOrPhoneController.text,
                'isFormForgotPassword': true,
              },
            );
          },
          loading: () => showLoadingDialog(context),
          error: (error) => handleError(context, error),
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
