import 'package:json_annotation/json_annotation.dart';

part 'report_statistics_model.g.dart';

@JsonSerializable()
class ReportStatisticsModel {
  final int totalReports;
  final int pendingReports;
  final int approvedReports;

  const ReportStatisticsModel({
    required this.totalReports,
    required this.pendingReports,
    required this.approvedReports,
  });

  factory ReportStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$ReportStatisticsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportStatisticsModelToJson(this);

  @override
  String toString() {
    return 'ReportStatisticsModel(totalReports: $totalReports, pendingReports: $pendingReports, approvedReports: $approvedReports)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ReportStatisticsModel &&
        other.totalReports == totalReports &&
        other.pendingReports == pendingReports &&
        other.approvedReports == approvedReports;
  }

  @override
  int get hashCode {
    return totalReports.hashCode ^
        pendingReports.hashCode ^
        approvedReports.hashCode;
  }
}
