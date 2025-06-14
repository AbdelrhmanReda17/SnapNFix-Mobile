// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportStatisticsModel _$ReportStatisticsModelFromJson(
        Map<String, dynamic> json) =>
    ReportStatisticsModel(
      pendingReports: (json['pendingReports'] as num).toInt(),
      approvedReports: (json['approvedReports'] as num).toInt(),
    );

Map<String, dynamic> _$ReportStatisticsModelToJson(
        ReportStatisticsModel instance) =>
    <String, dynamic>{
      'pendingReports': instance.pendingReports,
      'approvedReports': instance.approvedReports,
    };
