import 'package:json_annotation/json_annotation.dart';
import 'package:snapnfix/modules/reports/domain/entities/report.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';

part 'report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportModel extends Report {
  const ReportModel({
    required super.id,
    required super.details,
    required super.latitude,
    required super.longitude,
    required super.severity,
    required super.timestamp,
    required super.image,
    required super.issueId,
    super.category,
    super.threshold,
    super.status = ReportStatus.pending,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return _$ReportModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);

  ReportModel copyWith({
    String? id,
    String? details,
    double? latitude,
    double? longitude,
    ReportSeverity? severity,
    String? timestamp,
    String? image,
    String? category,
    double? threshold,
    ReportStatus? status,
    String? issueId,
  }) {
    return ReportModel(
      id: id ?? this.id,
      details: details ?? this.details,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      severity: severity ?? this.severity,
      timestamp: timestamp ?? this.timestamp,
      image: image ?? this.image,
      category: category ?? this.category,
      threshold: threshold ?? this.threshold,
      status: status ?? this.status,
      issueId: issueId ?? this.issueId,
    );
  }
}
