import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/reset_password/reset_password_bloc_listener.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/reset_password/reset_password_form.dart';
import 'package:snapnfix/presentation/components/application_system_ui_overlay.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final localization = AppLocalizations.of(context)!;
    final appConfigs = ApplicationConfigurations.instance;

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
                localization.resetPasswordTitle,
                style: textStyles.headlineLarge?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              Text(
                localization.resetPasswordSubtitle,
                style: textStyles.bodyLarge?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              verticalSpace(24),
              ResetPasswordForm(),
              verticalSpace(24),
              Text(
                localization.passwordRequirements,
                style: textStyles.bodySmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              verticalSpace(12),
              _buildRequirementItem(
                localization.passwordMinChars,
                colorScheme,
                textStyles.bodySmall?.copyWith(color: colorScheme.primary),
              ),
              _buildRequirementItem(
                localization.passwordUppercase,
                colorScheme,
                textStyles.bodySmall?.copyWith(color: colorScheme.primary),
              ),
              _buildRequirementItem(
                localization.passwordLowercase,
                colorScheme,
                textStyles.bodySmall?.copyWith(color: colorScheme.primary),
              ),
              _buildRequirementItem(
                localization.passwordNumber,
                colorScheme,
                textStyles.bodySmall?.copyWith(color: colorScheme.primary),
              ),
              _buildRequirementItem(
                localization.passwordSpecial,
                colorScheme,
                textStyles.bodySmall?.copyWith(color: colorScheme.primary),
              ),
              verticalSpace(32),
              BaseButton(
                text: localization.resetPassword,
                onPressed:
                    () =>
                        context.read<ResetPasswordCubit>().resetPassword(),
                backgroundColor: colorScheme.primary,
                textStyle: textStyles.bodyLarge!.copyWith(
                  color: colorScheme.surface,
                ),
              ),
              const ResetPasswordBlocListener(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementItem(
    String text,
    ColorScheme colorScheme,
    textStyle,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(color: colorScheme.primary, fontSize: 14.sp),
          ),
          Expanded(child: Text(text, style: textStyle)),
        ],
      ),
    );
  }
}
