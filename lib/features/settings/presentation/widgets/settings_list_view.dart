import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/theming/colors.dart';
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
    final localization = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: const EdgeInsets.all(0),
      color: ColorsManager.settingsColor,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSettingsTile(localization.changePassword, () {}),
              _buildSettingsTile(localization.notificationSettings, () {}),
              _buildSettingsTile(localization.support, () {}),
            ],
          ),
          SizedBox(height: 7.h),
          DarkModeTile(),
          LanguageTile(),
          SizedBox(height: 7.h),
          _buildSettingsTile(localization.termsAndConditions, () {}),
          _buildSettingsTile(localization.privacyPolicy, () {}),
          _buildSettingsTile(localization.about, () {}),
          SizedBox(height: 7.h),
          ListTile(
            tileColor: ColorsManager.whiteColor,
            title: Text(
              localization.signOut,
              style: TextStyle(color: ColorsManager.redColor),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(String title, VoidCallback onTap) {
    return ListTile(
      tileColor: ColorsManager.whiteColor,
      title: Text(title, style: TextStyle(color: ColorsManager.secondaryColor)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: ColorsManager.secondaryColor,
      ),
      onTap: onTap,
    );
  }
}
