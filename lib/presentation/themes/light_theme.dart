import 'package:flutter/material.dart';

class LightTheme {
  // Altert Colors
  static const _alertSuccessContainer = Color(0x33027243);
  static const _alertSuccessText = Color(0xFF027243);
  static const _alertErrorContainer = Color(0x33AC2634);
  static const _alertErrorText = Color(0xFFAC2634);
  static const _alertInfoContainer = Color(0xFFF0F6FF);
  static const _alertInfoText = Color(0xFF0F61AC);
  static const _alertWarningContainer = Color(0x33B84A1F);
  static const _alertWarningText = Color(0xFFB84A1F);

  static const ColorScheme lightColorTheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF083345),
    onPrimary: Colors.white,
    onPrimaryFixed: Color(0xFF23576D),

    secondary: Color(0xFF5C968B),
    onSecondary: Colors.white,

    tertiary: Color(0xFF083345),
    onTertiary: Colors.white,

    tertiaryContainer: Color(0x19CC4B4B),
    onTertiaryContainer: Color(0x164B8ECC),

    outline: Color(0xFFE0E0E0),

    error: Color(0xFFF44336),
    onError: Colors.white,

    surface: Colors.white,
    onSurface: Colors.black,
    surfaceContainer: Colors.white,

    primaryContainer: Color(0xFFD6E8F1),
    onPrimaryContainer: Color(0xFF083345),

    secondaryContainer: Color(0xFFD7E8E5),
    onSecondaryContainer: Color(0xFF345B5E),

    surfaceTint: Color(0xFFF5F5F5),
    onSurfaceVariant: Color(0xFF616161),

    surfaceContainerHighest: Color(0xFFEEEEEE),

    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF8B2635),
  );

  static const Map<String, Color> alertColors = {
    'successContainer': _alertSuccessContainer,
    'successText': _alertSuccessText,
    'errorContainer': _alertErrorContainer,
    'errorText': _alertErrorText,
    'infoContainer': _alertInfoContainer,
    'infoText': _alertInfoText,
    'warningContainer': _alertWarningContainer,
    'warningText': _alertWarningText,
  };
}
