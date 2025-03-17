import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/core/helpers/spacing.dart';
import 'package:snapnfix/core/theming/colors.dart';
import 'package:snapnfix/core/theming/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isObscureText;
  final bool isRememberMe;
  final VoidCallback toggleObscureText;
  final ValueChanged<bool> toggleRememberMe;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.isObscureText,
    required this.isRememberMe,
    required this.toggleObscureText,
    required this.toggleRememberMe,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Column(
          children: [
            BaseTextField(hintText: AppLocalizations.of(context)!.phone),
            verticalSpace(34),
            BaseTextField(
              hintText: AppLocalizations.of(context)!.password,
              isObscureText: isObscureText,
              suffixIcon: GestureDetector(
                onTap: toggleObscureText,
                child: Icon(
                  color: ColorsManager.primaryColor,
                  isObscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            verticalSpace(34),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => toggleRememberMe(!isRememberMe),
                        child: Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                            color: isRememberMe
                                ? ColorsManager.primaryColor
                                : ColorsManager.quaternaryColor,
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                          child: isRememberMe
                              ? const Icon(Icons.check, color: Colors.white, size: 16)
                              : null,
                        ),
                      ),
                      horizontalSpace(6),
                      Text(
                        AppLocalizations.of(context)!.rememberMe,
                        style: TextStyles.font14Normal(TextColor.primaryColor),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // Forget Password Screen
                    },
                    child: Text(
                      AppLocalizations.of(context)!.forgetPassword,
                      style: TextStyles.font14Normal(TextColor.primaryColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
