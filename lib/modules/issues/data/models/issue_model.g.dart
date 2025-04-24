// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueModel _$IssueModelFromJson(Map<String, dynamic> json) => IssueModel(
  id: json['id'] as String,
  severity: $enumDecode(_$IssueSeverityEnumMap, json['severity']),
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  status: $enumDecode(_$IssueStatusEnumMap, json['status']),
  category: json['category'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  resolvedAt:
      json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
  reports:
      (json['reports'] as List<dynamic>)
          .map((e) => ReportModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$IssueModelToJson(IssueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'status': _$IssueStatusEnumMap[instance.status]!,
      'category': instance.category,
      'createdAt': instance.createdAt.toIso8601String(),
      'severity': _$IssueSeverityEnumMap[instance.severity]!,
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
      'reports': instance.reports,
    };

const _$IssueSeverityEnumMap = {
  IssueSeverity.low: 'low',
  IssueSeverity.medium: 'medium',
  IssueSeverity.high: 'high',
};

const _$IssueStatusEnumMap = {
  IssueStatus.pending: 'pending',
  IssueStatus.inProgress: 'inProgress',
  IssueStatus.fixed: 'fixed',
};
