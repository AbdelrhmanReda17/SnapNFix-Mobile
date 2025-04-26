import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';

part 'issue_model.g.dart';

@JsonSerializable()
class IssueModel extends Issue {
  @override
  final List<ReportModel> reports;
  const IssueModel({
    required super.id,
    required super.severity,
    required super.latitude,
    required super.longitude,
    required super.status,
    required super.category,
    required super.createdAt,
    super.resolvedAt,
    required this.reports,
  }) : super(reports: reports);

  factory IssueModel.fromJson(Map<String, dynamic> json) =>
      _$IssueModelFromJson(json);

  Map<String, dynamic> toJson() => _$IssueModelToJson(this);
}
