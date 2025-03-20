import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/logo_and_name_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/helpers/extensions.dart';
import 'package:snapnfix/features/sign_up/logic/cubit/sign_up_cubit.dart';
import 'package:snapnfix/features/sign_up/presentation/widgets/sign_up_bloc_listener.dart';
import 'package:snapnfix/features/sign_up/presentation/widgets/sign_up_form.dart';
import '../../../../core/base_components/base_auth_footer.dart';
import '../../../../core/base_components/base_button.dart';
import '../../../../core/base_components/base_social_auth_component.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/text_styles.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              localization.createAccountTitle,
              style: TextStyles.font36Normal(TextColor.primaryColor),
            ),
            Text(
              localization.registerToContinue,
              style: TextStyles.font16Normal(TextColor.primaryColor),
            ),
            verticalSpace(20),
            SignUpForm(),
            verticalSpace(26),
            BaseButton(
              text: localization.signUp,
              onPressed: () {
                context.read<SignUpCubit>().emitSignUpStates();
              },
              textStyle: TextStyles.font16Normal(TextColor.whiteColor),
            ),
            verticalSpace(35),
            BaseSocialAuthComponent(),
            verticalSpace(35),
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: BaseAuthFooter(
                questionText: localization.alreadyHaveAcc,
                actionText: localization.signIn,
                onTap:
                    () => context.pushNamedAndRemoveUntil(
                      Routes.loginScreen,
                      predicate: (route) => false,
                    ),
              ),
            ),
            const SignUpBlocListener(),
          ],
        ),
      ),
    );
  }
}
