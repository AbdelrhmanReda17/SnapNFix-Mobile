import 'package:snapnfix/modules/area_updates/domain/entities/area_health_metrics.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';

class AreaDetails {
  final String areaName;
  final List<Issue> issues;
  final AreaHealthMetrics healthMetrics;
  final bool isSubscribed;

  const AreaDetails(
    this.areaName, {
    required this.issues,
    required this.healthMetrics,
    required this.isSubscribed,
  });
}
