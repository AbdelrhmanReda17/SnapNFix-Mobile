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
      category: $enumDecode(_$IssueCategoryEnumMap, json['category']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      resolvedAt: json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      reportsCount: (json['reportsCount'] as num).toInt(),
      road: json['road'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$IssueModelToJson(IssueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'status': _$IssueStatusEnumMap[instance.status]!,
      'category': _$IssueCategoryEnumMap[instance.category]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'severity': _$IssueSeverityEnumMap[instance.severity]!,
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
      'images': instance.images,
      'reportsCount': instance.reportsCount,
      'road': instance.road,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
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
  IssueStatus.fixed: 'fixed',
};

const _$IssueCategoryEnumMap = {
  IssueCategory.garbage: 'garbage',
  IssueCategory.defectiveManhole: 'defectiveManhole',
  IssueCategory.pothole: 'pothole',
};
