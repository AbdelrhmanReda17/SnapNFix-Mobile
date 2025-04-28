import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_password_text_field.dart';
import 'package:snapnfix/core/utils/extensions/validations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/reset_password/reset_password_cubit.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final cubit = context.read<ResetPasswordCubit>();

    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: cubit.newPasswordVisible,
            builder: (context, isVisible, child) {
              return BasePasswordTextField(
                text: localization.newPassword,
                controller: cubit.newPasswordController,
                togglePasswordObscureText:
                    () => cubit.toggleNewPasswordVisibility(),
                isPasswordObscureText: !isVisible,
                validator: (value) => value!.isNotEmpty
                  ? value.isValidPassword
                      ? null
                      : localization.passwordError
                  : localization.passwordRequired,
              );
            },
          ),
          verticalSpace(20),
          ValueListenableBuilder<bool>(
            valueListenable: cubit.confirmPasswordVisible,
            builder: (context, isVisible, child) {
              return BasePasswordTextField(
                text: localization.confirmNewPassword,
                controller: cubit.confirmPasswordController,
                togglePasswordObscureText:
                    () => cubit.toggleConfirmPasswordVisibility(),
                isPasswordObscureText: !isVisible,
                validator: (value) => value!.isNotEmpty
                  ? value.isValidConfirmPassword(cubit.newPasswordController.text)
                      ? null
                      : localization.passwordsDoNotMatch
                  : localization.confirmPasswordRequired,
              );
            },
          ),
        ],
      ),
    );
  }
}