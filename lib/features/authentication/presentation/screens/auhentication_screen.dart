import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/logo_and_name_widget.dart';

import 'package:snapnfix/core/helpers/spacing.dart';
import 'package:snapnfix/core/theming/text_styles.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/features/authentication/presentation/widgets/authentication_footer.dart';
import 'package:snapnfix/features/authentication/presentation/widgets/authentication_social.dart';

class AuthenticationScreen<T extends Cubit<void>> extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final String footerQuestion;
  final String footerAction;
  final VoidCallback onFooterTap;
  final Widget form;
  final Widget blocListener;
  final VoidCallback onSubmit;

  const AuthenticationScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.footerQuestion,
    required this.footerAction,
    required this.form,
    required this.blocListener,
    required this.onSubmit,
    required this.onFooterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
          children: [
            LogoAndNameWidget(),
            verticalSpace(26),
            Text(title, style: TextStyles.font36Normal(TextColor.primaryColor)),
            Text(
              subtitle,
              style: TextStyles.font16Normal(TextColor.primaryColor),
            ),
            verticalSpace(20),
            form,
            verticalSpace(26),
            BaseButton(
              text: buttonText,
              onPressed: onSubmit,
              textStyle: TextStyles.font16Normal(TextColor.whiteColor),
            ),
            verticalSpace(35),
            AuthenticationSocial(),
            verticalSpace(35),
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: AuthenticationFooter(
                questionText: footerQuestion,
                actionText: footerAction,
                onTap: onFooterTap,
              ),
            ),
            blocListener,
          ],
        ),
      ),
    );
  }
}
