import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_password_text_field.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/core/utils/extensions/validations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/register/register_cubit.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final cubit = context.read<RegisterCubit>();

    debugPrint("RegisterForm: ${cubit.state}");

    return Form(
      key: cubit.formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: BaseTextField(
                labelText: localizations.phone,
                hintText: "Enter your phone number",
                onChanged: cubit.setPhone,
                validator:
                    (value) =>
                        value!.isNotEmpty
                            ? value.isValidPhoneNumber
                                ? null
                                : localizations.phoneNumberError
                            : localizations.phoneNumberRequired,
              ),
            ),
            verticalSpace(12),
            SizedBox(
              width: double.infinity,
              child: BasePasswordTextField(
                text: localizations.password,
                hintText: "Enter your password",
                onChanged: cubit.setPassword,
                validator:
                    (value) =>
                        value!.isNotEmpty
                            ? value.isValidPassword
                                ? null
                                : localizations.passwordError
                            : localizations.passwordRequired,
              ),
            ),
            verticalSpace(12),
            SizedBox(
              width: double.infinity,
              child: BasePasswordTextField(
                text: localizations.repeatPassword,
                hintText: "Re-enter your password",
                onChanged: cubit.setConfirmPassword,
                validator:
                    (value) =>
                        value!.isNotEmpty
                            ? value.isValidConfirmPassword(cubit.password)
                                ? null
                                : localizations.passwordsDoNotMatch
                            : localizations.confirmPasswordRequired,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
