import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/core/helpers/spacing.dart';
import 'package:snapnfix/core/theming/colors.dart';
import 'package:snapnfix/core/theming/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpForm extends StatelessWidget {
  final bool isPasswordObscureText;
  final bool isPasswordConfirmationObscureText;
  final bool isAgreeTermsAndPolicy;

  final VoidCallback togglePasswordObscureText;
  final VoidCallback togglePasswordConfirmationObscureText;
  final ValueChanged<bool> toggleAgreeTermsAndPolicy;

  const SignUpForm({
    super.key,
    required this.isPasswordObscureText,
    required this.isPasswordConfirmationObscureText,
    required this.isAgreeTermsAndPolicy,
    required this.togglePasswordObscureText,
    required this.togglePasswordConfirmationObscureText,
    required this.toggleAgreeTermsAndPolicy,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Column(
          children: [
            BaseTextField(
              hintText: AppLocalizations.of(context)!.phone,
              controller: TextEditingController(),
            ),
            verticalSpace(25),
            BaseTextField(
              hintText: AppLocalizations.of(context)!.password,
              controller: TextEditingController(),
              isObscureText: isPasswordObscureText,
              isPassowrdTextField: true,
              toggleObscureText: togglePasswordObscureText,
            ),
            verticalSpace(25),
            BaseTextField(
              hintText: AppLocalizations.of(context)!.repeatPassword,
              controller: TextEditingController(),
              isObscureText: isPasswordConfirmationObscureText,
              isPassowrdTextField: true,
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
                                color: Colors.white,
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
                            recognizer: TapGestureRecognizer()..onTap = () {},
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
                            recognizer: TapGestureRecognizer()..onTap = () {},
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
