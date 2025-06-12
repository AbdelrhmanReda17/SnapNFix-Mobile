import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:snapnfix/modules/reports/domain/entities/report.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel extends Report {
  const ReportModel({
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

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);

  factory ReportModel.fromFile({
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
    return ReportModel(
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
    String? road,
    String? city,
    String? state,
    String? country,
  }) {
    return ReportModel(
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
