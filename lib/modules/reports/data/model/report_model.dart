import 'package:json_annotation/json_annotation.dart';
import 'package:snapnfix/modules/reports/data/model/media_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';

part 'report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportModel extends Report {
  @override
  final MediaModel reportMedia;
  
  const ReportModel({
    required super.id,
    required super.details,
    required super.latitude,
    required super.longitude,
    required super.severity,
    required super.timestamp,
    required this.reportMedia,
    required super.issueId,
    super.status = ReportStatus.pending,
  }) : super(reportMedia: reportMedia);

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
    MediaModel? reportMedia,
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
      reportMedia: reportMedia ?? this.reportMedia,
      status: status ?? this.status,
       issueId: issueId ?? this.issueId,
      

    );
  }
}
