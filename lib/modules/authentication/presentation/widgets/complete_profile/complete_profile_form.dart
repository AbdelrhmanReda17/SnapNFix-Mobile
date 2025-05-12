import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_password_text_field.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/core/utils/extensions/validations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/complete_profile/complete_profile_cubit.dart';

class CompleteProfileForm extends StatelessWidget {
  const CompleteProfileForm({super.key, this.password});
  final String? password;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final cubit = context.read<CompleteProfileCubit>();

    return Form(
      key: cubit.formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Column(
          children: [
            BaseTextField(
              hintText: localizations.enterFirstName,
              labelText: localizations.firstName,
              onChanged: cubit.setFirstName,
              validator:
                  (value) =>
                      value!.isNotEmpty
                          ? value.isValidName
                              ? null
                              : localizations.firstNameError
                          : localizations.firstNameRequired,
            ),
            verticalSpace(16),
            BaseTextField(
              hintText: localizations.enterLastName,
              labelText: localizations.lastName,
              onChanged: cubit.setLastName,
              validator:
                  (value) =>
                      value!.isNotEmpty
                          ? value.isValidName
                              ? null
                              : localizations.lastNameError
                          : localizations.lastNameRequired,
            ),
            verticalSpace(16),
            if (password == null) ...[
              BasePasswordTextField(
                text: localizations.password,
                hintText: localizations.enterPassword,
                onChanged: cubit.setPassword,
                validator:
                    (value) =>
                        value!.isNotEmpty
                            ? value.isValidPassword
                                ? null
                                : localizations.passwordError
                            : localizations.passwordRequired,
              ),
              verticalSpace(12),
              BasePasswordTextField(
                text: localizations.repeatPassword,
                hintText: localizations.reEnterPassword,
                onChanged: cubit.setRepeatPassword,
                validator:
                    (value) =>
                        value!.isNotEmpty
                            ? value.isValidConfirmPassword(
                                  password ?? cubit.password,
                                )
                                ? null
                                : localizations.passwordsDoNotMatch
                            : localizations.confirmPasswordRequired,
              ),

              verticalSpace(16),
            ],
          ],
        ),
      ),
    );
  }
}
