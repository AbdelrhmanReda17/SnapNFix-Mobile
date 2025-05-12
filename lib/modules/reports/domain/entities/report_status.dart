import 'package:flutter/material.dart';

enum ReportStatus {
  pending('Pending', Color(0xFF4CAF50)),
  verified('Verified',  Color(0xFFFF9800)),
  rejected('Rejected', Color(0xFFF44336));

  final String value;
  final Color color;

  const ReportStatus(this.value, this.color);

  bool get isActive => this == pending || this == pending;
  bool get isFinal => this == verified || this == rejected;

  static ReportStatus fromString(String value) {
    return ReportStatus.values.firstWhere(
      (status) => status.value.toLowerCase() == value.toLowerCase(),
      orElse: () => ReportStatus.pending,
    );
  }
}
