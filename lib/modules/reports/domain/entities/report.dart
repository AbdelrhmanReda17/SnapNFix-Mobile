import 'package:equatable/equatable.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';

abstract class Report extends Equatable {
  final String? id;
  final String? issueId;
  final ReportSeverity? severity;
  final DateTime? createdAt;
  final String? firstName;
  final String? lastName;

  const Report({
    this.id,
    this.issueId,
    this.severity,
    this.createdAt,
    this.firstName,
    this.lastName,
  });

  @override
  List<Object?> get props => [id, issueId, severity, createdAt];
}
