// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
  id: json['id'] as String,
  details: json['details'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  severity: $enumDecode(_$ReportSeverityEnumMap, json['severity']),
  timestamp: json['timestamp'] as String,
  image: json['image'] as String,
  issueId: json['issueId'] as String?,
  category: json['category'] as String?,
  threshold: (json['threshold'] as num?)?.toDouble(),
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
      'severity': _$ReportSeverityEnumMap[instance.severity]!,
      'timestamp': instance.timestamp,
      'image': instance.image,
      'category': instance.category,
      'threshold': instance.threshold,
      'status': _$ReportStatusEnumMap[instance.status]!,
    };

const _$ReportSeverityEnumMap = {
  ReportSeverity.low: 'low',
  ReportSeverity.medium: 'medium',
  ReportSeverity.high: 'high',
};

const _$ReportStatusEnumMap = {
  ReportStatus.pending: 'pending',
  ReportStatus.valid: 'valid',
  ReportStatus.invalid: 'invalid',
};
