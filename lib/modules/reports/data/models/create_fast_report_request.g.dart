// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_fast_report_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateFastReportRequest _$CreateFastReportRequestFromJson(
        Map<String, dynamic> json) =>
    CreateFastReportRequest(
      issueId: json['issueId'] as String,
      comment: json['comment'] as String,
      severity: $enumDecode(_$ReportSeverityEnumMap, json['severity']),
    );

Map<String, dynamic> _$CreateFastReportRequestToJson(
        CreateFastReportRequest instance) =>
    <String, dynamic>{
      'issueId': instance.issueId,
      'comment': instance.comment,
      'severity': instance.severity,
    };

const _$ReportSeverityEnumMap = {
  ReportSeverity.low: 'low',
  ReportSeverity.medium: 'medium',
  ReportSeverity.high: 'high',
};
