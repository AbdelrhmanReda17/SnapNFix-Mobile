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
  reportMedia: MediaModel.fromJson(json['reportMedia'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'details': instance.details,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'severity': _$ReportSeverityEnumMap[instance.severity]!,
      'timestamp': instance.timestamp,
      'reportMedia': instance.reportMedia.toJson(),
    };

const _$ReportSeverityEnumMap = {
  ReportSeverity.low: 'low',
  ReportSeverity.medium: 'medium',
  ReportSeverity.high: 'high',
};
