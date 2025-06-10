// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
  id: json['id'] as String?,
  details: json['details'] as String?,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  severity:
      $enumDecodeNullable(_$ReportSeverityEnumMap, json['severity']) ??
      ReportSeverity.low,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  imagePath: json['imagePath'] as String,
  issueId: json['issueId'] as String?,
  category: json['category'] as String?,
  status:
      $enumDecodeNullable(_$ReportStatusEnumMap, json['status']) ??
      ReportStatus.pending,
);

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'issueId': instance.issueId,
      'details': instance.details,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'createdAt': instance.createdAt?.toIso8601String(),
      'imagePath': instance.imagePath,
      'category': instance.category,
      'severity': _$ReportSeverityEnumMap[instance.severity],
      'status': _$ReportStatusEnumMap[instance.status],
    };

const _$ReportSeverityEnumMap = {
  ReportSeverity.low: 'low',
  ReportSeverity.medium: 'medium',
  ReportSeverity.high: 'high',
};

const _$ReportStatusEnumMap = {
  ReportStatus.pending: 'pending',
  ReportStatus.approved: 'approved',
  ReportStatus.declined: 'declined',
};
