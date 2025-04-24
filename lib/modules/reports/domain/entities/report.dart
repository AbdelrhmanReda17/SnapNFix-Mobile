import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:snapnfix/modules/reports/domain/entities/media.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';

class Report extends Equatable {
  final String id;
  final String details;
  final double latitude;
  final double longitude;
  final ReportSeverity severity;
  final String timestamp;
  final Media reportMedia;

  const Report({
    required this.id,
    required this.details,
    required this.latitude,
    required this.longitude,
    required this.severity,
    required this.timestamp,
    required this.reportMedia,
  });

  @override
  List<Object?> get props => [
    id,
    details,
    latitude,
    longitude,
    severity,
    timestamp,
    reportMedia,
  ];
}
