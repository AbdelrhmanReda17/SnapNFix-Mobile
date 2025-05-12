import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:snapnfix/core/utils/converters/file_converter.dart';
import 'package:snapnfix/modules/reports/domain/entities/report.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';

part 'report_model.g.dart';

class ReportModel extends Report {
  const ReportModel({
    super.id,
    required super.details,
    required super.latitude,
    required super.longitude,
    super.severity = ReportSeverity.low,
    super.createdAt,
    required super.image,
    super.issueId,
    super.category,
    super.status = ReportStatus.pending,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);


    ReportModel copyWithModel({
    String? id,
    String? issueId,
    String? details,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    File? image,
    String? category,
    ReportSeverity? severity,
    ReportStatus? status,
  }) {
    return ReportModel(
      id: id ?? this.id,
      issueId: issueId ?? this.issueId,
      details: details ?? this.details,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      image: image ?? this.image ?? File(''),
      category: category ?? this.category,
      severity: severity ?? this.severity,
      status: status ?? this.status,
    );
  }
}
