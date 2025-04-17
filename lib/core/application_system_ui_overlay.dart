import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApplicationSystemUIOverlay {
  // Private constructor to prevent instantiation
  ApplicationSystemUIOverlay._();
  
  // Default style for most screens
  static SystemUiOverlayStyle getDefaultStyle(bool isDarkMode) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
    );
  }
  
  // Style for settings screen
  static SystemUiOverlayStyle getSettingsStyle(Color primaryColor) {
    return SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    );
  }
  
}