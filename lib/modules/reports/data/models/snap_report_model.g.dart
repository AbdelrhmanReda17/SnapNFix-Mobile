// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snap_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnapReportModel _$SnapReportModelFromJson(Map<String, dynamic> json) =>
    SnapReportModel(
      id: json['id'] as String?,
      details: json['details'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      severity:
          $enumDecodeNullable(_$ReportSeverityEnumMap, json['severity']) ??
              ReportSeverity.low,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      imagePath: json['imagePath'] as String,
      city: json['city'] as String,
      road: json['road'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      issueId: json['issueId'] as String?,
      category: json['category'] as String?,
      status: $enumDecodeNullable(_$ReportStatusEnumMap, json['status']) ??
          ReportStatus.pending,
    );

Map<String, dynamic> _$SnapReportModelToJson(SnapReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'issueId': instance.issueId,
      'severity': _$ReportSeverityEnumMap[instance.severity],
      'createdAt': instance.createdAt?.toIso8601String(),
      'details': instance.details,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'road': instance.road,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'imagePath': instance.imagePath,
      'category': instance.category,
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
