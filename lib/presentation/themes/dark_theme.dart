import 'package:flutter/material.dart';

class DarkTheme {  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    error: Color(0xFFEF5350), // Lighter version of redColor
    onError: Colors.white,
    tertiaryContainer: Color.fromARGB(68, 216, 54, 54),
    onTertiaryContainer: Color.fromARGB(68, 36, 128, 214),
    primary: Color.fromRGBO(16, 80, 144, 1), // Attractive blue accent color
    outline: Color.fromARGB(255, 70, 68, 68), // lighterGray
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 27, 95, 154), // Lighter blue
    onSecondary: Colors.white,
    tertiary: Color.fromARGB(255, 25, 80, 128), // Darker blue
    onTertiary: Colors.white,
    surface: Color(0xFF242424), // Dark surface
    onSurface: Colors.white,
    primaryContainer: Color(0xFF2C5F87), // Blue container
    onPrimaryContainer: Colors.white,
    secondaryContainer: Color(0xFF3B7DB8), // Blue container
    onSecondaryContainer: Colors.white,
    surfaceVariant: Color(0xFF333333),
    onSurfaceVariant: Color(0xFFE0E0E0),
    surfaceContainerHighest: Color(0xFF2A2A2A),
    errorContainer: Color(0xFF8B2635),
    onErrorContainer: Colors.white,
  );
}
