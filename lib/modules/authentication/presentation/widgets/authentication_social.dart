import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/core/base_components/base_icon_button.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/login/login_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/mixins/authentication_listener_mixin.dart';

class AuthenticationSocial extends StatelessWidget
    with AuthenticationListenerMixin {
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
              onPressed:
                  () async =>
                      await context.read<LoginCubit>().signInWithFacebook(),
            ),
            horizontalSpace(25),
            BaseIconButton(
              assetPath: 'assets/images/google_icon.png',
              backgroundColor: colorScheme.tertiaryContainer,
              onPressed:
                  () async =>
                      await context.read<LoginCubit>().signInWithGoogle(),
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
    final localization = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(child: Divider(color: colorScheme.outline)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            localization.orContinueWith,
            style: textStyles.bodyMedium?.copyWith(color: colorScheme.outline),
          ),
        ),
        Expanded(child: Divider(color: colorScheme.outline)),
      ],
    );
  }
}
