import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/core/helpers/spacing.dart';
import 'package:snapnfix/core/theming/colors.dart';
import 'package:snapnfix/core/theming/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  void toggleAgreeTermsAndPolicy(bool value) {
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
            BaseTextField(
              hintText: AppLocalizations.of(context)!.password,
              controller: context.read<SignUpCubit>().passwordController,
              isObscureText: isPasswordObscureText,
              isPasswordTextField: true,
              toggleObscureText: togglePasswordObscureText,
            ),
            verticalSpace(25),
            BaseTextField(
              hintText: AppLocalizations.of(context)!.repeatPassword,
              controller: context.read<SignUpCubit>().passwordConfirmationController,
              isObscureText: isPasswordConfirmationObscureText,
              isPasswordTextField: true,
              toggleObscureText: togglePasswordConfirmationObscureText,
            ),
            verticalSpace(25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap:
                        () => toggleAgreeTermsAndPolicy(!isAgreeTermsAndPolicy),
                    child: Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color:
                            isAgreeTermsAndPolicy
                                ? ColorsManager.primaryColor
                                : ColorsManager.quaternaryColor,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                      child:
                          isAgreeTermsAndPolicy
                              ? const Icon(
                                Icons.check,
                                color: ColorsManager.whiteColor,
                                size: 16,
                              )
                              : null,
                    ),
                  ),
                  horizontalSpace(4),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.agreeWith,
                        style: TextStyles.font14Normal(TextColor.primaryColor),
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.termsOfServices,
                            style: TextStyles.font14Medium(
                              TextColor.secondaryColor,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              /// Terms of services screen
                            },
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.and,
                            style: TextStyles.font14Normal(
                              TextColor.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.privacyPolicy,
                            style: TextStyles.font14Medium(
                              TextColor.secondaryColor,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              /// Privacy Policy Screen
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
