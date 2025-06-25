import 'package:json_annotation/json_annotation.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';

part 'create_fast_report_request.g.dart';

@JsonSerializable()
class CreateFastReportRequest {
  final String issueId;
  final String comment;
  final String severity;

  CreateFastReportRequest({
    required this.issueId,
    required this.comment,
    required ReportSeverity severity,
  }): severity = severity.displayName.toLowerCase();

  factory CreateFastReportRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateFastReportRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateFastReportRequestToJson(this);
}