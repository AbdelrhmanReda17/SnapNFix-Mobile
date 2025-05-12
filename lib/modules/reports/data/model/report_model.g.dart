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
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  image: const FileConverter().fromJson(json['image'] as String?) ?? File(''),
  issueId: json['issue_id'] as String?,
  category: json['category'] as String?,
  status:
      $enumDecodeNullable(_$ReportStatusEnumMap, json['status']) ??
      ReportStatus.pending,
);

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'issue_id': instance.issueId,
      'details': instance.details,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'image': const FileConverter().toJson(instance.image),
      'created_at': instance.createdAt?.toIso8601String(),
      'category': instance.category,
      'severity': _$ReportSeverityEnumMap[instance.severity],
      'status': _$ReportStatusEnumMap[instance.status]!,
    };

const _$ReportSeverityEnumMap = {
  ReportSeverity.low: 'low',
  ReportSeverity.medium: 'medium',
  ReportSeverity.high: 'high',
};

const _$ReportStatusEnumMap = {
  ReportStatus.pending: 'pending',
  ReportStatus.verified: 'verified',
  ReportStatus.rejected: 'rejected',
};
