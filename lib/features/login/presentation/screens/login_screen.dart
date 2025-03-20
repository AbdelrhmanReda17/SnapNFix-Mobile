import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_auth_footer.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/base_components/base_social_auth_component.dart';
import 'package:snapnfix/core/helpers/extensions.dart';
import 'package:snapnfix/core/helpers/spacing.dart';
import 'package:snapnfix/core/theming/text_styles.dart';
import 'package:snapnfix/features/login/logic/cubit/login_cubit.dart';
import 'package:snapnfix/features/login/presentation/widgets/login_bloc_listener.dart';
import 'package:snapnfix/features/login/presentation/widgets/login_form.dart';
import 'package:snapnfix/core/base_components/logo_and_name_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/routing/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
          children: [
            LogoAndNameWidget(),
            verticalSpace(26),
            Text(
              localization.welcomeBack,
              style: TextStyles.font36Normal(TextColor.primaryColor),
            ),
            Text(
              localization.loginToContinue,
              style: TextStyles.font16Normal(TextColor.primaryColor),
            ),
            verticalSpace(20),
            LoginForm(),
            verticalSpace(26),
            BaseButton(
              text: localization.signIn,
              onPressed: () {
                context.read<LoginCubit>().emitLoginStates();
              },
              textStyle: TextStyles.font16Normal(TextColor.whiteColor),
            ),
            verticalSpace(35),
            BaseSocialAuthComponent(),
            verticalSpace(35),
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: BaseAuthFooter(
                questionText: localization.notRegistered,
                actionText: localization.createAccount,
                onTap:
                    () => context.pushNamedAndRemoveUntil(
                      Routes.signUpScreen,
                      predicate: (route) => false,
                    ),
              ),
            ),
            const LoginBlocListener(),
          ],
        ),
      ),
    );
  }
}
