import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/core/base_components/base_password_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/change_password_cubit.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<ChangePasswordCubit>().formKey,
      child: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable:
                context.read<ChangePasswordCubit>().oldPasswordVisible,
            builder: (context, isVisible, child) {
              return BasePasswordTextField(
                text: AppLocalizations.of(context)!.currentPassword,
                controller:
                    context.read<ChangePasswordCubit>().oldPasswordController,
                togglePasswordObscureText:
                    () =>
                        context
                            .read<ChangePasswordCubit>()
                            .toggleOldPasswordVisibility(),
                isPasswordObscureText: !isVisible,
              );
            },
          ),
          verticalSpace(20),
          ValueListenableBuilder<bool>(
            valueListenable:
                context.read<ChangePasswordCubit>().newPasswordVisible,
            builder: (context, isVisible, child) {
              return BasePasswordTextField(
                text: AppLocalizations.of(context)!.newPassword,
                controller:
                    context.read<ChangePasswordCubit>().newPasswordController,
                togglePasswordObscureText:
                    () =>
                        context
                            .read<ChangePasswordCubit>()
                            .toggleNewPasswordVisibility(),
                isPasswordObscureText: !isVisible,
              );
            },
          ),
          verticalSpace(20),
          ValueListenableBuilder<bool>(
            valueListenable:
                context.read<ChangePasswordCubit>().confirmPasswordVisible,
            builder: (context, isVisible, child) {
              return BasePasswordTextField(
                text: AppLocalizations.of(context)!.repeatPassword,
                controller:
                    context
                        .read<ChangePasswordCubit>()
                        .confirmPasswordController,
                togglePasswordObscureText:
                    () =>
                        context
                            .read<ChangePasswordCubit>()
                            .toggleConfirmPasswordVisibility(),
                isPasswordObscureText: !isVisible,
              );
            },
          ),
        ],
      ),
    );
  }
}
