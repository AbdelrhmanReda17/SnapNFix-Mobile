import 'package:flutter/material.dart';

class DarkTheme {
  // Alert Colors
  static const _alertSuccessContainer = Color(0xFF242424);
  static const _alertSuccessText = Color(0xFF26E69C);
  static const _alertErrorContainer = Color(0xFF242424);
  static const _alertErrorText = Color(0xFFFF5550);
  static const _alertInfoContainer = Color(0xFF242424);
  static const _alertInfoText = Color(0xFF64B5F6);
  static const _alertWarningContainer = Color(0xFF242424);
  static const _alertWarningText = Color(0xFFFFB74D);

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF345B5E),
    onPrimary: Colors.white,

    secondary: Color(0x80FFFFFF),
    onSecondary: Color(0xFF002D33),

    tertiary: Colors.white,
    onTertiary: Color(0xFF001F2A),

    tertiaryContainer: Color.fromARGB(68, 216, 54, 54),
    onTertiaryContainer: Color.fromARGB(68, 36, 128, 214),

    error: Color(0xFFEF5350),
    onError: Colors.white,

    outline: Color(0xFF464444),

    surface: Color(0xFF242424),
    onSurface: Colors.white,
    surfaceContainer: Color(0x13FFFFFF),

    primaryContainer: Color(0xFF345B5E),
    onPrimaryContainer: Colors.white,

    secondaryContainer: Color(0xFFB4D0CB),
    onSecondaryContainer: Color(0xFF002D33),

    surfaceTint: Color(0xFF333333),
    onSurfaceVariant: Color(0xFFE0E0E0),

    surfaceContainerHighest: Color(0xFF464444),

    errorContainer: Color(0xFF8B2635),
    onErrorContainer: Colors.white,
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
