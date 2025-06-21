import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum IssueSeverity {
  notSpecified(
    displayName: 'NotSpecified',
    color: Color(0xFF9E9E9E),
    icon: Icons.priority_high,
  ),
  low(displayName: 'Low', color: Color(0xFF4CAF50), icon: Icons.priority_high),
  medium(
    displayName: 'Medium',
    color: Color(0xFFFF9800),
    icon: Icons.priority_high,
  ),
  high(
    displayName: 'High',
    color: Color(0xFFF44336),
    icon: Icons.priority_high,
  );

  final String displayName;
  final Color color;
  final IconData icon;

  const IssueSeverity({
    required this.displayName,
    required this.color,
    required this.icon,
  });

  String getLocalizedName(AppLocalizations localization) {
    switch (this) {
      case IssueSeverity.notSpecified:
        return localization.notSpecified;
      case IssueSeverity.low:
        return localization.low;
      case IssueSeverity.medium:
        return localization.medium;
      case IssueSeverity.high:
        return localization.high;
    }
  }

  @override
  String toString() => displayName;

  Color get backgroundColor => color.withValues(alpha: 0.15);
  Color get borderColor => color.withValues(alpha: 0.5);
}
