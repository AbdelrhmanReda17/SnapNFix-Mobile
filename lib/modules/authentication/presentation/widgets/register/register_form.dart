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
    return Form(
      key: context.read<RegisterCubit>().formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Column(
          children: [
            BaseTextField(
              hintText: localizations.phone,
              controller: context.read<RegisterCubit>().phoneController,
              validator:
                  (value) =>
                      value!.isNotEmpty
                          ? value.isValidPhoneNumber
                              ? null
                              : localizations.phoneNumberError
                          : localizations.phoneNumberRequired,
            ),
            verticalSpace(20),
            BlocSelector<RegisterCubit, RegisterState, bool>(
              selector:
                  (state) => state.maybeWhen(
                    initial: (passwordVisible, _) => passwordVisible,
                    orElse: () => false,
                  ),
              builder: (context, isPasswordVisible) {
                return BasePasswordTextField(
                  text: localizations.password,
                  isPasswordObscureText: !isPasswordVisible,
                  togglePasswordObscureText:
                      context.read<RegisterCubit>().togglePasswordVisibility,
                  controller: context.read<RegisterCubit>().passwordController,
                  validator:
                      (value) =>
                          value!.isNotEmpty
                              ? value.isValidPassword
                                  ? null
                                  : localizations.passwordError
                              : localizations.passwordRequired,
                );
              },
            ),
            verticalSpace(20),
            BlocSelector<RegisterCubit, RegisterState, bool>(
              selector:
                  (state) => state.maybeWhen(
                    initial:
                        (_, confirmPasswordVisible) => confirmPasswordVisible,
                    orElse: () => false,
                  ),
              builder: (context, isConfirmPasswordVisible) {
                return BasePasswordTextField(
                  text: localizations.repeatPassword,
                  isPasswordObscureText: !isConfirmPasswordVisible,
                  togglePasswordObscureText:
                      context
                          .read<RegisterCubit>()
                          .toggleConfirmPasswordVisibility,
                  controller:
                      context.read<RegisterCubit>().confirmPasswordController,
                  validator:
                      (value) =>
                          value!.isNotEmpty
                              ? value.isValidConfirmPassword(
                                    context
                                        .read<RegisterCubit>()
                                        .passwordController
                                        .text,
                                  )
                                  ? null
                                  : localizations.passwordsDoNotMatch
                              : localizations.confirmPasswordRequired,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
