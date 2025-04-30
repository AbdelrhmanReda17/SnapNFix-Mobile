import 'package:equatable/equatable.dart';
import 'package:snapnfix/modules/reports/domain/entities/media.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';

class Report extends Equatable {
  final String id;
  final String details;
  final double latitude;
  final double longitude;
  final ReportSeverity severity;
  final String timestamp;
  final Media reportMedia;
  final ReportStatus status;

  const Report({
    required this.id,
    required this.details,
    required this.latitude,
    required this.longitude,
    required this.severity,
    required this.timestamp,
    required this.reportMedia,
    this.status = ReportStatus.pending,
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
    status,
  ];
}
