import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_checkbox.dart';
import 'package:snapnfix/core/base_components/base_password_text_field.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/core/helpers/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/features/authentication/presentation/widgets/signup/terms_and_privacy_policy.dart';
import '../../../logic/cubit/sign_up_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isPasswordObscureText = true;
  bool isPasswordConfirmationObscureText = true;
  bool isAgreeTermsAndPolicy = false;

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

  void toggleAgreeTermsAndPolicy(bool? value) {
    if (value == null) return;
    setState(() {
      isAgreeTermsAndPolicy = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignUpCubit>().formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Column(
          children: [
            BaseTextField(
              hintText: AppLocalizations.of(context)!.phone,
              controller: context.read<SignUpCubit>().phoneController,
            ),
            verticalSpace(25),
            BasePasswordTextField(
              text: AppLocalizations.of(context)!.password,
              isPasswordObscureText: isPasswordObscureText,
              togglePasswordObscureText: togglePasswordObscureText,
              controller: context.read<SignUpCubit>().passwordController,
            ),
            verticalSpace(25),
            BasePasswordTextField(
              text: AppLocalizations.of(context)!.repeatPassword,
              isPasswordObscureText: isPasswordConfirmationObscureText,
              togglePasswordObscureText: togglePasswordConfirmationObscureText,
              controller:
                  context.read<SignUpCubit>().passwordConfirmationController,
            ),
            verticalSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BaseCheckbox(
                  value: isAgreeTermsAndPolicy,
                  onChanged: toggleAgreeTermsAndPolicy,
                ),
                horizontalSpace(4),
                Expanded(
                  child: TermsAndPrivacyPolicy(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
