import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/application_configurations.dart';
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
                () {},
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
          ListTile(
            tileColor: colorScheme.surface.withValues(alpha: 0.8),
            title: Text(
              localization.signOut,
              style: textStyles.bodyMedium?.copyWith(color: colorScheme.error),
            ),
            onTap: () {
              appConfigs.logout();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    String title,
    VoidCallback onTap,
    ColorScheme colorScheme,
    TextTheme textSyles,
  ) {
    return ListTile(
      tileColor: colorScheme.surface.withValues(alpha: 0.8),
      title: Text(
        title,
        style: textSyles.bodyMedium?.copyWith(color: colorScheme.primary),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: colorScheme.primary,
      ),
      onTap: onTap,
    );
  }
}
