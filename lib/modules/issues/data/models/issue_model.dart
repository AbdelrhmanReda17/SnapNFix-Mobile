import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';

part 'issue_model.g.dart';

@JsonSerializable()
class IssueModel extends Issue {
  @override
  const IssueModel({
    required super.id,
    required super.severity,
    required super.latitude,
    required super.longitude,
    required super.status,
    required super.category,
    required super.createdAt,
    super.resolvedAt,
    required super.images,
    required super.reportsCount,
    required super.location,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) =>
      _$IssueModelFromJson(json);

  Map<String, dynamic> toJson() => _$IssueModelToJson(this);
}
