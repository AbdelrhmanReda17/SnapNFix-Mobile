import 'package:equatable/equatable.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';

class Issue extends Equatable {
  final String id;
  final double latitude;
  final double longitude;
  final IssueStatus status;
  final IssueCategory category;
  final DateTime createdAt;
  final IssueSeverity severity;
  final DateTime? resolvedAt;
  final List<String> images;
  final int reportsCount;
  final String road;
  final String city;
  final String state;
  final String country;

  const Issue({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.severity,
    required this.status,
    required this.category,
    required this.createdAt,
    this.resolvedAt,
    required this.images,
    required this.reportsCount,
    required this.road,
    required this.city,
    required this.state,
    required this.country,
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
    severity,
    images,
    reportsCount,
    road,
    city,
    state,
    country,
  ];
}
