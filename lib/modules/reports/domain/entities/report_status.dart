import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ReportStatus {
  pending('Pending', Color(0xFFFF9800)),
  approved('Approved', Color(0xFF4CAF50)),
  declined('Declined', Color(0xFFF44336));

  final String value;
  final Color color;

  const ReportStatus(this.value, this.color);

  String getLocalizedName(AppLocalizations localization) {
    switch (this) {
      case ReportStatus.pending:
        return localization.pending;
      case ReportStatus.approved:
        return localization.approved;
      case ReportStatus.declined:
        return localization.declined;
    }
  }

  bool get isActive => this == pending || this == pending;
  bool get isFinal => this == approved || this == declined;

  static ReportStatus fromString(String value) {
    return ReportStatus.values.firstWhere(
      (status) => status.value.toLowerCase() == value.toLowerCase(),
      orElse: () => ReportStatus.pending,
    );
  }
}
