import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/forget_password/forgot_password_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/forgot_password/forgot_password_bloc_listener.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/forgot_password/forget_password_form.dart';
import 'package:snapnfix/presentation/components/application_system_ui_overlay.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final appConfigs = ApplicationConfigurations.instance;
    final localization = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ApplicationSystemUIOverlay.getDefaultStyle(appConfigs.isDarkMode),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: colorScheme.primary, size: 24.sp),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            children: [
              Text(
                localization.forgotPasswordTitle,
                style: textStyles.headlineLarge?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              Text(
                localization.forgotPasswordSubtitle,
                style: textStyles.bodyLarge?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              verticalSpace(24),
              ForgetPasswordForm(),
              verticalSpace(24),
              BaseButton(
                text: localization.sendCode,
                onPressed:
                    () =>
                        context
                            .read<ForgotPasswordCubit>()
                            .emitForgotPasswordStates(),
                backgroundColor: colorScheme.primary,
                textStyle: textStyles.bodyLarge!.copyWith(
                  color: colorScheme.surface,
                ),
              ),
              const ForgetPasswordBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}
