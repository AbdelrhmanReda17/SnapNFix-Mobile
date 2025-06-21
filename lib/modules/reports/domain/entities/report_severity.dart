import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ReportSeverity {
  low(displayName: 'Low', color: Color(0xFF4CAF50), priority: 1),
  medium(displayName: 'Medium', color: Color(0xFFFF9800), priority: 2),
  high(displayName: 'High', color: Color(0xFFF44336), priority: 3);

  final String displayName;
  final Color color;
  final int priority;

  const ReportSeverity({
    required this.displayName,
    required this.color,
    required this.priority,
  });

  String getLocalizedName(AppLocalizations localization) {
    switch (this) {
      case ReportSeverity.low:
        return localization.low;
      case ReportSeverity.medium:
        return localization.medium;
      case ReportSeverity.high:
        return localization.high;
    }
  }

  @override
  String toString() => displayName;

  Color get backgroundColor => color.withValues(alpha: 0.15);
  Color get borderColor => color.withValues(alpha: .5);
  Color get textColor => color;

  static ReportSeverity fromPriority(int priority) {
    return ReportSeverity.values.firstWhere(
      (severity) => severity.priority == priority,
      orElse: () => ReportSeverity.medium,
    );
  }

  static ReportSeverity fromString(String value) {
    return ReportSeverity.values.firstWhere(
      (severity) => severity.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => ReportSeverity.medium,
    );
  }

  bool operator >(ReportSeverity other) => priority > other.priority;
  bool operator <(ReportSeverity other) => priority < other.priority;
  bool operator >=(ReportSeverity other) => priority >= other.priority;
  bool operator <=(ReportSeverity other) => priority <= other.priority;
}
