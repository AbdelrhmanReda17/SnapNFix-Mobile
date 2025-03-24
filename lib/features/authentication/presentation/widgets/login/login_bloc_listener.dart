import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/routes.dart';
import 'package:snapnfix/core/theming/colors.dart';
import 'package:snapnfix/core/theming/text_styles.dart';
import 'package:snapnfix/features/authentication/logic/cubit/login_cubit.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (loginResponse) {
            context.go(
              Routes.homeScreen.key,
            );
          },
          error: (error) {
            setupErrorState(context, error);
          },
          loading: () {
            showDialog(
              context: context,
              builder:
                  (context) => const Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.primaryColor,
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
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            icon: const Icon(
              Icons.error,
              color: ColorsManager.redColor,
              size: 32,
            ),
            content: Text(
              error,
              style: TextStyles.font24Bold(TextColor.primaryColor),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  'Got it',
                  style: TextStyles.font14Medium(TextColor.primaryColor),
                ),
              ),
            ],
          ),
    );
  }
}
