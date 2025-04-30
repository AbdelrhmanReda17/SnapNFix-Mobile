import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/login/login_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/mixins/authentication_listener_mixin.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class LoginBlocListener extends StatelessWidget
    with AuthenticationListenerMixin {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (session) {
            context.go(Routes.homeScreen.key);
          },
          unauthenticated: (phoneNumber) {},
          requiresOtp: (phoneNumber, token) {
            debugPrint('Requires verification');
            context.pop();
            baseDialog(
              context: context,
              title: "Verification Required",
              message: "Please verify your email or phone number to continue.",
              onConfirm: () {
                context.pop();
                context.push(
                  Routes.otpScreen.key,
                  extra: {
                    'emailOrPhoneNumber': phoneNumber,
                    'verificationToken': token,
                    'purpose': OtpPurpose.login,
                  },
                );
              },
              alertType: AlertType.info,
              confirmText: "Verify",
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
