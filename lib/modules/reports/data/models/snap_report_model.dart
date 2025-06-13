import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';
import 'package:snapnfix/modules/reports/domain/entities/snap_report.dart';

part 'snap_report_model.g.dart';

@JsonSerializable()
class SnapReportModel extends SnapReport {
  const SnapReportModel({
    super.id,
    required super.details,
    required super.latitude,
    required super.longitude,
    super.severity = ReportSeverity.low,
    super.createdAt,
    required super.imagePath,
    required super.city,
    required super.road,
    required super.state,
    required super.country,
    super.issueId,
    super.category,
    super.status = ReportStatus.pending,
  });

  factory SnapReportModel.fromJson(Map<String, dynamic> json) =>
      _$SnapReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$SnapReportModelToJson(this);

  factory SnapReportModel.fromFile({
    String? id,
    String? details,
    required double latitude,
    required double longitude,
    ReportSeverity? severity = ReportSeverity.low,
    DateTime? createdAt,
    required File image, // Accept a File
    required String road,
    required String city,
    required String state,
    required String country,
    String? issueId,
    String? category,
    ReportStatus? status = ReportStatus.pending,
  }) {
    return SnapReportModel(
      id: id,
      details: details ?? '',
      latitude: latitude,
      longitude: longitude,
      severity: severity,
      createdAt: createdAt ?? DateTime.now(),
      imagePath: image.path,
      issueId: issueId,
      road: road,
      state: state,
      country: country,
      city: city,
      category: category,
      status: status,
    );
  }

  SnapReportModel copyWithModel({
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
    String? road,
    String? city,
    String? state,
    String? country,
  }) {
    return SnapReportModel(
      id: id ?? this.id,
      issueId: issueId ?? this.issueId,
      details: details ?? this.details,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      imagePath: image?.path ?? imagePath,
      category: category ?? this.category,
      severity: severity ?? this.severity,
      road: road ?? this.road,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      status: status ?? this.status,
    );
  }
}
