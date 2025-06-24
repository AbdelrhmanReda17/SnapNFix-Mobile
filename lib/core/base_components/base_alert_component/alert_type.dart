import 'package:flutter/material.dart';
import 'package:snapnfix/presentation/themes/dark_theme.dart';
import 'package:snapnfix/presentation/themes/light_theme.dart';

enum AlertType {
  success,
  error,
  info,
  warning;
  
  Color getContainerColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final alertColors = brightness == Brightness.dark 
        ? DarkTheme.alertColors
        : LightTheme.alertColors;
    
    switch (this) {
      case AlertType.success:
        return alertColors['successContainer']!;
      case AlertType.error:
        return alertColors['errorContainer']!;
      case AlertType.info:
        return alertColors['infoContainer']!;
      case AlertType.warning:
        return alertColors['warningContainer']!;
    }
  }
  
  Color getTextColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final alertColors = brightness == Brightness.dark 
        ? DarkTheme.alertColors
        : LightTheme.alertColors;
    
    switch (this) {
      case AlertType.success:
        return alertColors['successText']!;
      case AlertType.error:
        return alertColors['errorText']!;
      case AlertType.info:
        return alertColors['infoText']!;
      case AlertType.warning:
        return alertColors['warningText']!;
    }
  }
  
  IconData get icon {
    switch (this) {
      case AlertType.success:
        return Icons.check_circle_outline;
      case AlertType.error:
        return Icons.error_outline;
      case AlertType.info:
        return Icons.info_outline;
      case AlertType.warning:
        return Icons.warning;
    }
  }
}