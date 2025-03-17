import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/logo_and_name_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/features/sign_up/presentation/widgets/sign_up_form.dart';
import '../../../../core/base_components/base_auth_footer.dart';
import '../../../../core/base_components/base_button.dart';
import '../../../../core/base_components/base_social_auth_component.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/text_styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordObscureText = true;
  bool isPasswordConfirmationObscureText = true;
  bool isAgreeTermsAndPolicy = false;

  void togglePasswordObscureText(){
    setState(() {
      isPasswordObscureText = !isPasswordObscureText;
    });
  }

  void togglePasswordConfirmationObscureText(){
    setState(() {
      isPasswordConfirmationObscureText = !isPasswordConfirmationObscureText;
    });
  }

  void toggleAgreeTermsAndPolicy(bool value){
    setState(() {
      isAgreeTermsAndPolicy = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LogoAndNameWidget(),
                      verticalSpace(40),
                      Text(
                        localization.createAccountTitle,
                        style: TextStyles.font36Normal(TextColor.primaryColor),
                      ),
                      Text(
                        localization.registerToContinue,
                        style: TextStyles.font16Normal(TextColor.primaryColor),
                      ),
                      verticalSpace(28),
                      SignUpForm(
                          isPasswordObscureText: isPasswordObscureText,
                          isPasswordConfirmationObscureText: isPasswordConfirmationObscureText,
                          isAgreeTermsAndPolicy: isAgreeTermsAndPolicy,
                          togglePasswordObscureText: togglePasswordObscureText,
                          togglePasswordConfirmationObscureText: togglePasswordConfirmationObscureText,
                          toggleAgreeTermsAndPolicy: toggleAgreeTermsAndPolicy
                      ),
                      verticalSpace(26),
                      BaseButton(
                          text: localization.signUp,
                          onPressed: (){
                            // To be done
                          },
                          textStyle: TextStyles.font16Normal(TextColor.whiteColor)),
                      verticalSpace(40),
                      BaseSocialAuthComponent(),
                      verticalSpace(40.h),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: BaseAuthFooter(
                      questionText: localization.alreadyHaveAcc,
                      actionText: localization.signIn,
                      onTap: () => Navigator.pushReplacementNamed(context, Routes.loginScreen),
                    )
                ),
              )
            ]
          )
      ),
    );
  }
}