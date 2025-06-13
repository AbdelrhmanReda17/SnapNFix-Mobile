import 'package:flutter/material.dart';

class DarkTheme {
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    error: Color(0xFFEF5350), // Lighter version of redColor
    onError: Colors.white,
    tertiaryContainer: Color.fromARGB(68, 216, 54, 54),
    onTertiaryContainer: Color.fromARGB(68, 36, 128, 214),
    primary: Color(0xFFc5dbd7), // primaryColor
    outline: Color.fromARGB(255, 70, 68, 68), // lighterGray
    onPrimary: Colors.white,
    secondary: Color(0xFF2b6d89), // secondaryColor
    onSecondary: Colors.white,
    tertiary: Color(0xFF083345), // tertiaryColor
    onTertiary: Colors.white,
    surface: Color(0xFF242424), // Dark surface
    onSurface: Colors.white,
  );
}
