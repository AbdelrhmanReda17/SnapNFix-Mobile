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
          BasePasswordTextField(
            text: localization.newPassword,
            onChanged: cubit.setNewPassword,
            validator:
                (value) =>
                    value!.isNotEmpty
                        ? value.isValidPassword
                            ? null
                            : localization.passwordError
                        : localization.passwordRequired,
          ),
          verticalSpace(20),
          BasePasswordTextField(
            text: localization.confirmNewPassword,
            onChanged: cubit.setConfirmPassword,
            validator:
                (value) =>
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
