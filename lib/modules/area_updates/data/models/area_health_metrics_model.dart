import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_health_metrics.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/health_condition.dart';

part 'area_health_metrics_model.g.dart';


@JsonSerializable()
class AreaHealthMetricsModel extends AreaHealthMetrics {
  const AreaHealthMetricsModel({
    required super.inProgressIssuesCount,
    required super.fixedIssuesCount,
    required super.pendingIssuesCount,
    required super.totalSubscribers,
    required super.healthCondition,
    required super.healthPercentage,
  });

  factory AreaHealthMetricsModel.fromJson(Map<String, dynamic> json) =>
      _$AreaHealthMetricsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AreaHealthMetricsModelToJson(this);
}
