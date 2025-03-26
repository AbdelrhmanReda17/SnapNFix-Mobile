import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/application_configurations.dart';
import 'package:snapnfix/core/helpers/shared_pref_helper.dart';
import 'package:snapnfix/core/helpers/shared_pref_keys.dart';

part 'settings_state.dart';
part 'settings_cubit.freezed.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState(isDarkMode: false, language: "en")) {
    log("SettingsCubit created");
    emit(
      state.copyWith(
        language: ApplicationConfigurations.language,
        isDarkMode: ApplicationConfigurations.isDarkMode,
      ),
    );
  }

  void changeLanguage(String newLanguage) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.language, newLanguage);
    emit(state.copyWith(language: newLanguage));
  }

  void toggleDarkMode(bool value) async {
    await SharedPrefHelper.setData(SharedPrefKeys.isDarkMode, value);
    emit(state.copyWith(isDarkMode: value));
  }
}
