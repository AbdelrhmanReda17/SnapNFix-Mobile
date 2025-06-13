import 'package:equatable/equatable.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';

abstract class Report extends Equatable {
  final String? id;
  final String? issueId;
  final ReportSeverity? severity;
  final DateTime? createdAt;

  const Report({this.id, this.issueId, this.severity, this.createdAt});

  @override
  List<Object?> get props => [id, issueId, severity, createdAt];
}
