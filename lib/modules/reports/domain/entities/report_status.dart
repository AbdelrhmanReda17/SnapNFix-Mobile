import 'package:flutter/material.dart';

enum ReportStatus {
  pending('Pending', Color(0xFF4CAF50)),
  approved('Approved',  Color(0xFFFF9800)),
  declined('declined', Color(0xFFF44336));

  final String value;
  final Color color;

  const ReportStatus(this.value, this.color);

  bool get isActive => this == pending || this == pending;
  bool get isFinal => this == approved || this == declined;

  static ReportStatus fromString(String value) {
    return ReportStatus.values.firstWhere(
      (status) => status.value.toLowerCase() == value.toLowerCase(),
      orElse: () => ReportStatus.pending,
    );
  }
}
