import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_auth_footer.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/base_components/base_social_auth_component.dart';
import 'package:snapnfix/core/helpers/spacing.dart';
import 'package:snapnfix/core/theming/text_styles.dart';
import 'package:snapnfix/features/login/presentation/widgets/login_form.dart';
import 'package:snapnfix/core/base_components/logo_and_name_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/routing/routes.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isObscureText = true;
  bool isRememberMe = false;

  void toggleObscureText(){
    setState(() {
      isObscureText = !isObscureText;
    });
  }

  void toggleRememberMe(bool value){
    setState(() {
      isRememberMe = value;
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
                      localization.welcomeBack,
                      style: TextStyles.font36Normal(TextColor.primaryColor),
                    ),
                    Text(
                      localization.loginToContinue,
                      style: TextStyles.font16Normal(TextColor.primaryColor),
                    ),
                    verticalSpace(28),
                    LoginForm(
                        formKey: formKey,
                        isObscureText: isObscureText,
                        isRememberMe: isRememberMe,
                        toggleObscureText: toggleObscureText,
                        toggleRememberMe: toggleRememberMe,
                    ),
                    verticalSpace(26),
                    BaseButton(
                        text: localization.singIn,
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
                  questionText: localization.notRegistered,
                  actionText: localization.createAccount,
                  onTap: () => Navigator.pushReplacementNamed(context, Routes.signUpScreen),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
