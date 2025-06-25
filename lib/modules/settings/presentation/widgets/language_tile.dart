import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/config/application_constants.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final appConfigs = getIt<ApplicationConfigurations>();
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    return ListenableBuilder(
      listenable: appConfigs,
      builder: (context, _) {
        return ListTile(
          tileColor: colorScheme.surface.withValues(alpha: 0.8),          title: Text(
            localization.language,
            style: textStyles.bodyMedium?.copyWith(
              color: Theme.of(context).brightness == Brightness.dark 
                  ? colorScheme.onPrimary 
                  : colorScheme.primary,
            ),
          ),
          onTap: () {
            _showLanguageDialog(context, localization);
          },          trailing: Text(
            ApplicationConstants.availableLanguages[appConfigs.language] ?? '',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark 
                  ? colorScheme.onPrimary 
                  : colorScheme.secondary.withValues(alpha: 0.5),
            ),
          ),
        );
      },
    );
  }

  void _showLanguageDialog(
    BuildContext context,
    AppLocalizations localization,
  ) {
    final appConfigs = getIt<ApplicationConfigurations>();
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ListenableBuilder(
          listenable: appConfigs,
          builder: (context, _) {
            return AlertDialog(
              title: Text(
                localization.selectLanguage,
                style: TextStyle(color: colorScheme.primary),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (MapEntry<String, String> lang
                      in ApplicationConstants.availableLanguages.entries)
                    ListTile(
                      title: Text(lang.value),
                      leading: Radio<String>(
                        activeColor: colorScheme.primary,
                        value: lang.key,
                        groupValue: appConfigs.language,
                        onChanged: (value) {
                          if (value != null) {
                            appConfigs.changeLanguage(value);
                            Navigator.pop(context);
                          }
                        },
                      ),
                      onTap: () {
                        appConfigs.changeLanguage(lang.key);
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
