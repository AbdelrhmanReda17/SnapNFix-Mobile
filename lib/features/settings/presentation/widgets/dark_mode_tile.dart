import 'package:flutter/material.dart';
import 'package:snapnfix/core/application_configurations.dart';
import 'package:snapnfix/core/base_components/base_switch.dart';
import 'package:snapnfix/core/theming/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DarkModeTile extends StatelessWidget {
  const DarkModeTile({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final appConfigs = ApplicationConfigurations.instance;

    return ListenableBuilder(
      listenable: appConfigs,
      builder: (context, _) {
        return ListTile(
          tileColor: ColorsManager.whiteColor,
          title: Text(
            localization.darkMode,
            style: TextStyle(color: ColorsManager.secondaryColor),
          ),
          onTap: () => appConfigs.toggleDarkMode(!appConfigs.isDarkMode),
          trailing: BaseSwitch(
            value: appConfigs.isDarkMode,
            onChanged: (value) => appConfigs.toggleDarkMode(value),
          ),
        );
      },
    );
  }
}
