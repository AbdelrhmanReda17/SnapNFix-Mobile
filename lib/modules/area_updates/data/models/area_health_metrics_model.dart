import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_health_metrics.dart';

part 'area_health_metrics_model.g.dart';

@JsonSerializable()
class AreaHealthMetricsModel extends AreaHealthMetrics {
  const AreaHealthMetricsModel({
    required super.totalIssues,
    required super.closedIssues,
    required super.resolvedIssues,
    required super.areaHealthScore,
    required super.openIssues,
  });

  factory AreaHealthMetricsModel.fromJson(Map<String, dynamic> json) =>
      _$AreaHealthMetricsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AreaHealthMetricsModelToJson(this);
}
