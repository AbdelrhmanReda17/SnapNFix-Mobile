import 'package:flutter/material.dart';

enum ReportSeverity {
  low(displayName: 'Low', color: Color(0xFF4CAF50)),
  medium(displayName: 'Medium', color: Color(0xFFFF9800)),
  high(displayName: 'High', color: Color(0xFFF44336));

  final String displayName;
  final Color color;

  const ReportSeverity({required this.displayName, required this.color});

  @override
  String toString() => displayName;

  Color get backgroundColor => color.withValues(alpha: 0.15);
  Color get borderColor => color.withValues(alpha: 0.5);
}