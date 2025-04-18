import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/application_configurations.dart';
import 'package:snapnfix/core/routes.dart';
import 'package:snapnfix/features/settings/presentation/widgets/dark_mode_tile.dart';
import 'package:snapnfix/features/settings/presentation/widgets/language_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsListView extends StatefulWidget {
  const SettingsListView({super.key});

  @override
  State<SettingsListView> createState() => _SettingsListViewState();
}

class _SettingsListViewState extends State<SettingsListView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final appConfigs = ApplicationConfigurations.instance;
    final localization = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: const EdgeInsets.all(0),
      color: colorScheme.surface.withValues(alpha: 0.8),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSettingsTile(
                localization.changePassword,
                () {
                  context.push(Routes.changePassowrd.key);
                },
                colorScheme,
                textStyles,
              ),
              _buildSettingsTile(
                localization.notificationSettings,
                () {},
                colorScheme,
                textStyles,
              ),
              _buildSettingsTile(
                localization.support,
                () {},
                colorScheme,
                textStyles,
              ),
            ],
          ),
          SizedBox(height: 7.h),
          DarkModeTile(),
          LanguageTile(),
          SizedBox(height: 7.h),
          _buildSettingsTile(
            localization.termsAndConditions,
            () {},
            colorScheme,
            textStyles,
          ),
          _buildSettingsTile(
            localization.privacyPolicy,
            () {},
            colorScheme,
            textStyles,
          ),
          _buildSettingsTile(
            localization.about,
            () {},
            colorScheme,
            textStyles,
          ),
          SizedBox(height: 7.h),
          _buildSettingsTile(
            localization.signOut,
            () {
              appConfigs.logout();
            },
            colorScheme,
            textStyles,
            hasIcon: false,
            isSignOut: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    String title,
    VoidCallback onTap,
    ColorScheme colorScheme,
    TextTheme textStyles, {
    bool hasIcon = true,
    bool isSignOut = false,
  }) {
    final WidgetStatesController statesController = WidgetStatesController();

    return InkWell(
      onTap: onTap,
      statesController: statesController,
      highlightColor: colorScheme.primary.withValues(alpha: 0.3),
      splashColor: colorScheme.primary.withValues(alpha: 0.3),
      child: Container(
        color: colorScheme.surface.withValues(alpha: 0.8),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textStyles.bodyMedium?.copyWith(
                color: isSignOut ? colorScheme.error : colorScheme.primary,
              ),
            ),
            hasIcon
                ? Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: colorScheme.primary,
                  size: 16.sp,
                )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
