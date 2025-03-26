import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/core/application_constants.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/core/theming/colors.dart';
import 'package:snapnfix/features/settings/presentation/logic/cubit/settings_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (BuildContext context, SettingsState state) {
        return ListTile(
          tileColor: ColorsManager.whiteColor,
          title: Text(
            localization.language,
            style: TextStyle(color: ColorsManager.secondaryColor),
          ),
          onTap: () {
            _showLanguageDialog(context, state, localization);
          },
          trailing: Text(
            ApplicationConstants.availableLanguages[state.language] ?? '',
            style: TextStyle(color: ColorsManager.grayColor),
          ),
        );
      },
    );
  }

  void _showLanguageDialog(
    BuildContext context,
    SettingsState state,
    AppLocalizations localization,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                    groupValue: state.language,
                    onChanged: (value) {
                      context.read<SettingsCubit>().changeLanguage(value!);
                      Navigator.pop(context);
                    },
                  ),
                  onTap: () {
                    context.read<SettingsCubit>().changeLanguage(lang.key);
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
