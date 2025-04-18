import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/base_components/base_icon_button.dart';

class AuthenticationSocial extends StatelessWidget {
  const AuthenticationSocial({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    return Column(
      children: [
        OrContinueWith(colorScheme: colorScheme, textStyles: textStyles),
        verticalSpace(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseIconButton(
              assetPath: 'assets/images/facebook_icon.png',
              backgroundColor: colorScheme.onTertiaryContainer,
              onPressed: () {
                // Handle Facebook login
              },
            ),
            horizontalSpace(25),
            BaseIconButton(
              assetPath: 'assets/images/google_icon.png',
              backgroundColor: colorScheme.tertiaryContainer,
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

class OrContinueWith extends StatelessWidget {
  const OrContinueWith({
    super.key,
    required this.colorScheme,
    required this.textStyles,
  });

  final ColorScheme colorScheme;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: colorScheme.primary.withValues(alpha: 0.4),
            thickness: 1.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            AppLocalizations.of(context)!.orContinueWith,
            style: textStyles.bodyMedium?.copyWith(
              color: colorScheme.primary,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: colorScheme.primary.withValues(alpha: 0.4),
            thickness: 1.h,
          ),
        ),
      ],
    );
  }
}
