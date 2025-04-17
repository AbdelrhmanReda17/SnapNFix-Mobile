import 'package:flutter/material.dart';

class LightTheme {
  static const ColorScheme lightColorTheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF083345), // primaryColor
    tertiaryContainer: Color(0x19CC4B4B),
    onTertiaryContainer: Color(0x164B8ECC),
    outline: Color(0xFFE0E0E0), // lighterGray
    onPrimary: Colors.white,
    secondary: Color(0xFF5C968B), // secondaryColor
    onSecondary: Colors.white,
    tertiary: Color(0xFFC0D8CF), // tertiaryColor
    onTertiary: Colors.white,
    error: Color(0xFFF44336), // redColor
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  );
}
