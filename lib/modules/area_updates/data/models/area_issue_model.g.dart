// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_issue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaIssueModel _$AreaIssueModelFromJson(Map<String, dynamic> json) =>
    AreaIssueModel(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      category: $enumDecode(_$IssueCategoryEnumMap, json['category']),
      severity: $enumDecode(_$IssueSeverityEnumMap, json['severity']),
      status: $enumDecode(_$IssueStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AreaIssueModelToJson(AreaIssueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imagePath': instance.imagePath,
      'category': _$IssueCategoryEnumMap[instance.category]!,
      'severity': _$IssueSeverityEnumMap[instance.severity]!,
      'status': _$IssueStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$IssueCategoryEnumMap = {
  IssueCategory.garbage: 'garbage',
  IssueCategory.defectiveManhole: 'defectiveManhole',
  IssueCategory.pothole: 'pothole',
  IssueCategory.nonDefectiveManhole: 'nonDefectiveManhole',
};

const _$IssueSeverityEnumMap = {
  IssueSeverity.notSpecified: 'notSpecified',
  IssueSeverity.low: 'low',
  IssueSeverity.medium: 'medium',
  IssueSeverity.high: 'high',
};

const _$IssueStatusEnumMap = {
  IssueStatus.pending: 'pending',
  IssueStatus.inProgress: 'inProgress',
  IssueStatus.completed: 'completed',
};
