import 'package:flutter/material.dart';

enum ReportStatus {
  pending('Pending', Color(0xFF4CAF50)),
  valid('Valid',  Color(0xFFFF9800)),
  invalid('Invalid', Color(0xFFF44336));

  final String value;
  final Color color;

  const ReportStatus(this.value, this.color);
}
