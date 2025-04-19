import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_checkbox.dart';
import 'package:snapnfix/core/base_components/base_password_text_field.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/login/login_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/login/forget_password.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isObscureText = true;
  bool isRememberMe = false;
  void toggleObscureText() {
    setState(() {
      isObscureText = !isObscureText;
    });
  }

  void toggleRememberMe(bool? value) {
    if (value == null) return;
    setState(() {
      isRememberMe = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Column(
          children: [
            BaseTextField(
              hintText: AppLocalizations.of(context)!.phone,
              controller: context.read<LoginCubit>().emailOrPhoneController,
            ),
            verticalSpace(25),
            BasePasswordTextField(
              text: AppLocalizations.of(context)!.password,
              isPasswordObscureText: isObscureText,
              togglePasswordObscureText: toggleObscureText,
              controller: context.read<LoginCubit>().passwordController,
            ),
            verticalSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    BaseCheckbox(
                      value: isRememberMe,
                      onChanged: toggleRememberMe,
                    ),
                    horizontalSpace(6),
                    Text(
                      AppLocalizations.of(context)!.rememberMe,
                      style: textStyles.bodyMedium!.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                ForgetPassword(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
