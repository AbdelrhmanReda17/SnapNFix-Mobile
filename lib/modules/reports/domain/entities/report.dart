import 'package:equatable/equatable.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';

class Report extends Equatable {
  final String id;
  final String? issueId;
  final String details;
  final double latitude;
  final double longitude;
  final ReportSeverity severity;
  final String timestamp;
  final String image;
  final String? category;
  final double? threshold;
  final ReportStatus status;

  const Report({
    required this.id,
    this.issueId,
    required this.details,
    required this.latitude,
    required this.longitude,
    required this.severity,
    required this.timestamp,
    required this.image,
    this.category,
    this.threshold,
    this.status = ReportStatus.pending,
  });

  @override
  List<Object?> get props => [
    id,
    issueId,
    details,
    latitude,
    longitude,
    severity,
    timestamp,
    image,
    category,
    threshold,
    status,
  ];
}
