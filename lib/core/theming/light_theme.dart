import 'package:flutter/material.dart';

class LightTheme {
  static const ColorScheme lightColorTheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF083345), // primaryColor
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFFC0D8CF), // quaternaryColor
    onPrimaryContainer: const Color(0xFF083345),
    secondary: Color(0xFF1F5B55), // secondaryColor
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFD6F2EA),
    onSecondaryContainer: Color(0xFF1F5B55),
    tertiary: Color(0xFF5C968B), // tertiaryColor
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFE6F3EF),
    onTertiaryContainer: Color(0xFF5C968B),
    error: Color(0xFFF44336), // redColor
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFFB3261E),
    surface: Colors.white,
    onSurface: Colors.black,
    onSurfaceVariant: Color(0xFF8A8989), // grayColor
    outline: Color(0xFFE0E0E0), // lightGrayColor
  );
}
