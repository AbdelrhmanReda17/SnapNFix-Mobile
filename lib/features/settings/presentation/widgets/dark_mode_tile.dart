import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/core/base_components/base_checkbox.dart';
import 'package:snapnfix/core/base_components/base_switch.dart';
import 'package:snapnfix/core/theming/colors.dart';
import 'package:snapnfix/features/settings/presentation/logic/cubit/settings_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DarkModeTile extends StatelessWidget {
  const DarkModeTile({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (BuildContext context, SettingsState state) {
        return ListTile(
          tileColor: ColorsManager.whiteColor,
          title: Text(
            localization.darkMode,
            style: TextStyle(color: ColorsManager.secondaryColor),
          ),
          onTap:
              () => context.read<SettingsCubit>().toggleDarkMode(
                !state.isDarkMode,
              ),
          trailing: BaseSwitch(
            value: state.isDarkMode,
            onChanged:
                (value) => context.read<SettingsCubit>().toggleDarkMode(value),
          ),
        );
      },
    );
  }
}
