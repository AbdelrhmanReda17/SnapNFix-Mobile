import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/login/login_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/mixins/authentication_listener_mixin.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class LoginBlocListener extends StatelessWidget with ListenerMixin {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (session) {
            dismissLoadingAndExecute(context, () {
              context.go(Routes.home);
            });
          },
          requiresProfileCompletion: () {
            dismissLoadingAndExecute(context, () {
              context.go(Routes.completeProfile);
            });
          },
          loading: () => showLoadingDialog(context),
          error: (error) => handleError(context, error),
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
