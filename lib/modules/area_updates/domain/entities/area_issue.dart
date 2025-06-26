import 'package:equatable/equatable.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';

class AreaIssue extends Equatable {
  final String id;
  final String imagePath;
  final IssueCategory category;
  final IssueSeverity severity;
  final IssueStatus status;
  final DateTime createdAt;

  const AreaIssue({
    required this.id,
    required this.imagePath,
    required this.category,
    required this.severity,
    required this.status,
    required this.createdAt,
  });


  @override
  List<Object?> get props => [
    id,
    imagePath,
    category,
    severity,
    status,
    createdAt,
  ];

}
