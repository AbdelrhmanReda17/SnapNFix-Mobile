import 'package:flutter/material.dart';
import 'package:snapnfix/core/base_components/base_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';

class DarkModeTile extends StatelessWidget {
  const DarkModeTile({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final appConfigs = getIt<ApplicationConfigurations>();
    final colorScheme = Theme.of(context).colorScheme;
    final textSyles = Theme.of(context).textTheme;

    return ListenableBuilder(
      listenable: appConfigs,
      builder: (context, _) {
        return ListTile(
          tileColor: colorScheme.surface.withValues(alpha: 0.8),
          title: Text(
            localization.darkMode,
            style: textSyles.bodyMedium?.copyWith(color: colorScheme.primary),
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
