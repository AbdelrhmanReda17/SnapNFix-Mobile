import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_password_text_field.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/core/utils/extensions/validations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/login/login_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/login/forget_password.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Column(
          children: [
            BaseTextField(
              hintText: localizations.emailOrPhone,
              controller: context.read<LoginCubit>().emailOrPhoneController,
              validator:
                  (value) =>
                      value!.isNotEmpty
                          ? value.isValidEmailOrPhone
                              ? null
                              : localizations.emailOrPhoneRequiredAndValid
                          : localizations.emailOrPhoneRequiredAndValid,
            ),
            verticalSpace(20),
            BlocSelector<LoginCubit, LoginState, bool>(
              selector:
                  (state) => state.maybeWhen(
                    initial: (passwordVisible) => passwordVisible,
                    orElse: () => false,
                  ),
              builder: (context, isPasswordVisible) {
                return BasePasswordTextField(
                  text: localizations.password,
                  isPasswordObscureText: !isPasswordVisible,
                  togglePasswordObscureText:
                      context.read<LoginCubit>().togglePasswordVisibility,
                  controller: context.read<LoginCubit>().passwordController,
                  validator:
                      (value) =>
                          value!.isNotEmpty
                              ? null
                              : localizations.passwordRequired,
                );
              },
            ),
            verticalSpace(20),
            Align(alignment: Alignment.centerRight, child: ForgetPassword()),
          ],
        ),
      ),
    );
  }
}
