import 'package:flutter/material.dart';

class DarkTheme {
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF88C4B8), // Lighter version of primaryColor
    onPrimary: Color(0xFF083345),
    primaryContainer: Color(0xFF0B4659), // Darker version of primaryColor
    onPrimaryContainer: Color(0xFFC0D8CF),
    secondary: Color(0xFF6FBCB1), // Lighter version of secondaryColor
    onSecondary: Color(0xFF1F5B55),
    secondaryContainer: Color(0xFF2B7A72), // Darker version of secondaryColor
    onSecondaryContainer: Color(0xFFD6F2EA),
    tertiary: Color(0xFF8ACED8), // Lighter version of tertiaryColor
    onTertiary: Color(0xFF5C968B),
    tertiaryContainer: Color(0xFF4A7A71), // Darker version of tertiaryColor
    onTertiaryContainer: Color(0xFFE6F3EF),
    error: Color(0xFFEF5350), // Lighter version of redColor
    onError: Colors.white,
    errorContainer: Color(0xFF8B1D16), // Darker version of redColor
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF1E1E1E), // Dark surface
    onSurface: Colors.white,
    surfaceVariant: Color(0xFF2C2C2C), // Dark settingsColor
    onSurfaceVariant: Color(0xFFB8B8B8), // Light grayColor
    outline: Color(0xFF444444), // Dark lightGrayColor
  );
}
