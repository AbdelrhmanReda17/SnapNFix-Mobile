import 'package:json_annotation/json_annotation.dart';
import 'package:snapnfix/modules/reports/domain/entities/fast_report.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';

part 'fast_report_model.g.dart';

@JsonSerializable()
class FastReportModel extends FastReport {
  const FastReportModel({
    super.id,
    required super.issueId,
    required super.comment,
    required super.severity,
    super.isUserReport = false,
    super.createdAt,
    required super.firstName,
    required super.lastName,
  });

  factory FastReportModel.fromJson(Map<String, dynamic> json) =>
      _$FastReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$FastReportModelToJson(this);
}
