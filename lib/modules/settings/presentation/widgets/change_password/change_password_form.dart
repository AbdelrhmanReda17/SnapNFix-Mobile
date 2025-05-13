import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/core/base_components/base_password_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/extensions/validations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/change_password_cubit.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChangePasswordCubit>();
    final localization = AppLocalizations.of(context)!;

    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          BasePasswordTextField(
            text: localization.currentPassword,
            hintText: localization.enterCurrentPassword,
            onChanged: cubit.setOldPassword,
            validator:
                (value) =>
                    value!.isNotEmpty
                        ? null
                        : localization.currentPasswordRequired,
          ),
          verticalSpace(20),
          BasePasswordTextField(
            text: AppLocalizations.of(context)!.newPassword,
            hintText: localization.enterNewPassword,
            onChanged: (value) {
              cubit.setNewPassword;
              cubit.formKey.currentState!.validate();
            },
            validator: (value) {
              if (value!.isEmpty) {
                return localization.passwordRequired;
              }
              if (!value.isValidPassword) {
                return localization.passwordError;
              }
              // Check that new password is different from old password
              if (value == cubit.oldPassword) {
                return localization.newPasswordMustBeDifferent;
              }
              return null;
            },
          ),
          verticalSpace(20),
          BasePasswordTextField(
            text: localization.repeatPassword,
            hintText: localization.reEnterPassword,
            onChanged: (cubit.setConfirmPassword),
            validator: (value) =>
                        value!.isNotEmpty
                            ? value.isValidConfirmPassword(cubit.newPassword)
                                ? null
                                : localization.passwordsDoNotMatch
                            : localization.confirmPasswordRequired,
          ),
        ],
      ),
    );
  }
}
