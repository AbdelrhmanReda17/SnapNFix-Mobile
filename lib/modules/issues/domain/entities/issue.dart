import 'package:equatable/equatable.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';
import '../../../reports/domain/entities/report.dart';

class Issue extends Equatable {
  final String id;
  final double latitude;
  final double longitude;
  final IssueStatus status;
  final IssueCategory category;
  final DateTime createdAt;
  final IssueSeverity severity;
  final DateTime? resolvedAt;
  final List<Report> reports;

  const Issue({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.severity,
    required this.status,
    required this.category,
    required this.createdAt,
    this.resolvedAt,
    required this.reports,
  });

  @override
  List<Object?> get props => [
    id,
    latitude,
    longitude,
    status,
    category,
    createdAt,
    resolvedAt,
    reports,
  ];
}
