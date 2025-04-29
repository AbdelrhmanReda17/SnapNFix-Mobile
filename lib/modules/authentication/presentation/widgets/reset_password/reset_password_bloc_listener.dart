import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/mixins/authentication_listener_mixin.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class ResetPasswordBlocListener extends StatelessWidget
    with AuthenticationListenerMixin {
  const ResetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (isSucess) {
            handleSuccess(
              context,
              message: 'Password reset successfully',
              route: Routes.loginScreen.key,
            );
          },
          loading: () => showLoadingDialog(context),
          error: (error) => handleError(context, error),
        );
      },
      child: SizedBox.shrink(),
    );
  }
}
