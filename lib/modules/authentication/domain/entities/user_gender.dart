import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum UserGender {
  male("Male"),
  female("Female"),
  notSpecified("Not Specified");

  final String displayName;
  const UserGender(this.displayName);

  String getLocalizedDisplayName(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    switch (this) {
      case UserGender.male:
        return localization.male;
      case UserGender.female:
        return localization.female;
      case UserGender.notSpecified:
        return localization.notSpecified;
    }
  }

  static List<String> getLocalizedStringValues(BuildContext context) {
    return UserGender.values
        .map((e) => e.getLocalizedDisplayName(context))
        .toList();
  }

  get getStringValues {
    return UserGender.values.map((e) => e.displayName).toList();
  }

  static UserGender fromString(String value) {
    return UserGender.values.firstWhere(
      (gender) => gender.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => UserGender.notSpecified,
    );
  }
}
