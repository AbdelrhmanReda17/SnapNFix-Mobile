import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/core/helpers/spacing.dart';
import 'package:snapnfix/core/theming/colors.dart';
import 'package:snapnfix/core/theming/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/features/authentication/logic/cubit/login_cubit.dart';

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

  void toggleRememberMe(bool value) {
    setState(() {
      isRememberMe = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Column(
          children: [
            BaseTextField(
              hintText: AppLocalizations.of(context)!.phone,
              controller: context.read<LoginCubit>().emailController,
            ),
            verticalSpace(25),
            BaseTextField(
              controller: context.read<LoginCubit>().passwordController,
              hintText: AppLocalizations.of(context)!.password,
              isObscureText: isObscureText,
              isPasswordTextField: true,
              toggleObscureText: toggleObscureText,
            ),
            verticalSpace(25),
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
                          height: 20.h,
                          decoration: BoxDecoration(
                            color:
                                isRememberMe
                                    ? ColorsManager.primaryColor
                                    : ColorsManager.quaternaryColor,
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                          child:
                              isRememberMe
                                  ? const Icon(
                                    Icons.check,
                                    color: ColorsManager.whiteColor,
                                    size: 16,
                                  )
                                  : null,
                        ),
                      ),
                      horizontalSpace(6),
                      Text(
                        AppLocalizations.of(context)!.rememberMe,
                        style: TextStyles.font14Normal(TextColor.primaryColor),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      /// Forget Password Screen
                    },
                    child: Text(
                      AppLocalizations.of(context)!.forgetPassword,
                      style: TextStyles.font14Normal(TextColor.primaryColor),
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