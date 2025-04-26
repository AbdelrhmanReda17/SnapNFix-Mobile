import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_password_text_field.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/core/utils/extensions/validations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/register/register_cubit.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool isPasswordObscureText = true;
  bool isPasswordConfirmationObscureText = true;

  void togglePasswordObscureText() {
    setState(() {
      isPasswordObscureText = !isPasswordObscureText;
    });
  }

  void togglePasswordConfirmationObscureText() {
    setState(() {
      isPasswordConfirmationObscureText = !isPasswordConfirmationObscureText;
    });
  }

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
              // width: MediaQuery.of(context).size.width * 0.4,
              hintText: localizations.firstName,
              controller: context.read<RegisterCubit>().firstNameController,
              validator:
                  (value) =>
                      value!.isNotEmpty
                          ? value.isValidFirstName
                              ? null
                              : localizations.firstNameError
                          : localizations.firstNameRequired,
            ),
            verticalSpace(20),
            BaseTextField(
              // width: MediaQuery.of(context).size.width * 0.4,
              hintText: localizations.lastName,
              controller: context.read<RegisterCubit>().lastNameController,
              validator:
                  (value) =>
                      value!.isNotEmpty
                          ? value.isValidLastName
                              ? null
                              : localizations.lastNameError
                          : localizations.lastNameRequired,
            ),
            verticalSpace(20),
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
            BasePasswordTextField(
              text: localizations.password,
              isPasswordObscureText: isPasswordObscureText,
              togglePasswordObscureText: togglePasswordObscureText,
              controller: context.read<RegisterCubit>().passwordController,
              validator:
                  (value) =>
                      value!.isNotEmpty
                          ? value.isValidPassword
                              ? null
                              : localizations.passwordError
                          : localizations.passwordRequired,
            ),
            verticalSpace(20),
            BasePasswordTextField(
              text: localizations.repeatPassword,
              isPasswordObscureText: isPasswordConfirmationObscureText,
              togglePasswordObscureText: togglePasswordConfirmationObscureText,
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
            ),
          ],
        ),
      ),
    );
  }
}
