import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../logic/cubit/sign_up_cubit.dart';

class SignUpBlocListener extends StatelessWidget {
  const SignUpBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (signUpResponse) {
            context.pushNamedAndRemoveUntil(
              Routes.homeScreen,
              predicate: (route) => false,
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
          icon: const Icon(Icons.error, color: ColorsManager.redColor, size: 32),
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
