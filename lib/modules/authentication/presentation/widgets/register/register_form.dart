import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_password_text_field.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
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
    return Form(
      key: context.read<RegisterCubit>().formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BaseTextField(
                  width: MediaQuery.of(context).size.width * 0.4,
                  hintText: AppLocalizations.of(context)!.firstName,
                  controller: context.read<RegisterCubit>().firstNameController,
                ),
                BaseTextField(
                  width: MediaQuery.of(context).size.width * 0.4,
                  hintText: AppLocalizations.of(context)!.lastName,
                  controller: context.read<RegisterCubit>().lastNameController,
                ),
              ],
            ),
            verticalSpace(20),
            BaseTextField(
              hintText: AppLocalizations.of(context)!.phone,
              controller: context.read<RegisterCubit>().phoneController,
            ),
            verticalSpace(20),
            BasePasswordTextField(
              text: AppLocalizations.of(context)!.password,
              isPasswordObscureText: isPasswordObscureText,
              togglePasswordObscureText: togglePasswordObscureText,
              controller: context.read<RegisterCubit>().passwordController,
            ),
            verticalSpace(20),
            BasePasswordTextField(
              text: AppLocalizations.of(context)!.repeatPassword,
              isPasswordObscureText: isPasswordConfirmationObscureText,
              togglePasswordObscureText: togglePasswordConfirmationObscureText,
              controller:
                  context.read<RegisterCubit>().confirmPasswordController,
            ),
          ],
        ),
      ),
    );
  }
}
