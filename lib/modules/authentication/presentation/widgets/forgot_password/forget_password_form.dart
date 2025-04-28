import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/core/utils/extensions/validations.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/forget_password/forgot_password_cubit.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final cubit = context.read<ForgotPasswordCubit>();

    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BaseTextField(
            hintText: localization.emailOrPhone,
            controller: cubit.emailOrPhoneController,
            validator: (value) => value!.isNotEmpty
                  ? value.isValidEmailOrPhone
                      ? null
                      : localization.emailOrPhoneRequiredAndValid
                  : localization.emailOrPhoneRequiredAndValid,
          ),
        ],
      ),
    );
  }
}