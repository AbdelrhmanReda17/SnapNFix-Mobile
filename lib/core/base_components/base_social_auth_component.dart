import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/spacing.dart';
import '../theming/colors.dart';
import '../theming/text_styles.dart';
import 'base_social_auth_button.dart';

class BaseSocialAuthComponent extends StatelessWidget {
  const BaseSocialAuthComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Divider(color: ColorsManager.lightGrayColor, thickness: 2.h,)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                AppLocalizations.of(context)!.orContinueWith,
                style: TextStyles.font14Normal(TextColor.primaryColor),
              ),
            ),
            Expanded(child: Divider(color: ColorsManager.lightGrayColor, thickness: 2.h,)),
          ],
        ),
        verticalSpace(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseSocialAuthButton(
              assetPath: 'assets/images/facebook_icon.png',
              backgroundColor: ColorsManager.facebookContainerColor,
              onPressed: () {
                // Handle Facebook login
              },
            ),
            SizedBox(width: 16.w),
            BaseSocialAuthButton(
              assetPath: 'assets/images/google_icon.png',
              backgroundColor: ColorsManager.googleContainerColor,
              onPressed: () {
                // Handle Google login
              },
            ),
          ],
        ),
      ],
    );
  }
}
