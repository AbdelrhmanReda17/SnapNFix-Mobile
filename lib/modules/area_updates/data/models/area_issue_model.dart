import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_issue.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';

part 'area_issue_model.g.dart';


@JsonSerializable()
class AreaIssueModel extends AreaIssue {
  const AreaIssueModel({
    required super.id,
    required super.imagePath,
    required super.category,
    required super.severity,
    required super.status,
    required super.createdAt,
  });

  factory AreaIssueModel.fromJson(Map<String, dynamic> json) =>
      _$AreaIssueModelFromJson(json);

  Map<String, dynamic> toJson() => _$AreaIssueModelToJson(this);
}
