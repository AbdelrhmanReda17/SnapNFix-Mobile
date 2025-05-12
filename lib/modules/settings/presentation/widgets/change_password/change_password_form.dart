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
          BasePasswordTextField(
            text: AppLocalizations.of(context)!.currentPassword,
            onChanged: (context.read<ChangePasswordCubit>().setOldPassword),
            validator:
                (value) =>
                    value!.isNotEmpty ? null : " Current password is required",
          ),
          verticalSpace(20),
          BasePasswordTextField(
            text: AppLocalizations.of(context)!.newPassword,
            onChanged: (context.read<ChangePasswordCubit>().setNewPassword),
          ),
          verticalSpace(20),
          BasePasswordTextField(
            text: AppLocalizations.of(context)!.repeatPassword,
            onChanged: (context.read<ChangePasswordCubit>().setConfirmPassword),
          ),
        ],
      ),
    );
  }
}
