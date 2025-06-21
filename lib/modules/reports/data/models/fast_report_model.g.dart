// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fast_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FastReportModel _$FastReportModelFromJson(Map<String, dynamic> json) =>
    FastReportModel(
      id: json['id'] as String?,
      issueId: json['issueId'] as String,
      comment: json['comment'] as String,
      severity: ReportSeverity.medium,
      isUserReport: json['isUserReport'] as bool? ?? false,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      firstName: json['userFirstName'] as String?,
      lastName: json['userLastName'] as String?,
    );

Map<String, dynamic> _$FastReportModelToJson(FastReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'issueId': instance.issueId,
      'severity': _$ReportSeverityEnumMap[instance.severity],
      'createdAt': instance.createdAt?.toIso8601String(),
      'comment': instance.comment,
      'isUserReport': instance.isUserReport,
      'userFirstName': instance.firstName,
      'userLastName': instance.lastName,
    };

const _$ReportSeverityEnumMap = {
  ReportSeverity.notSpecified: 'notSpecified',
  ReportSeverity.low: 'low',
  ReportSeverity.medium: 'medium',
  ReportSeverity.high: 'high',
};
