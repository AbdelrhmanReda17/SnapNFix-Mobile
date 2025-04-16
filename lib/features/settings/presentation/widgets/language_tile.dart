import 'package:flutter/material.dart';
import 'package:snapnfix/core/application_configurations.dart';
import 'package:snapnfix/core/application_constants.dart';
import 'package:snapnfix/core/theming/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});

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
            localization.language,
            style: TextStyle(color: ColorsManager.secondaryColor),
          ),
          onTap: () {
            _showLanguageDialog(context, localization);
          },
          trailing: Text(
            ApplicationConstants.availableLanguages[appConfigs.language] ?? '',
            style: TextStyle(color: ColorsManager.grayColor),
          ),
        );
      },
    );
  }

  void _showLanguageDialog(
    BuildContext context,
    AppLocalizations localization,
  ) {
    final appConfigs = ApplicationConfigurations.instance;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ListenableBuilder(
          listenable: appConfigs,
          builder: (context, _) {
            return AlertDialog(
              title: Text(
                localization.selectLanguage,
                style: TextStyle(color: ColorsManager.secondaryColor),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (MapEntry<String, String> lang
                      in ApplicationConstants.availableLanguages.entries)
                    ListTile(
                      title: Text(lang.value),
                      leading: Radio<String>(
                        activeColor: ColorsManager.primaryColor,
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
