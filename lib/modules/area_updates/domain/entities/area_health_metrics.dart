import 'package:equatable/equatable.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/health_condition.dart';


class AreaHealthMetrics extends Equatable {
  final int inProgressIssuesCount;
  final int fixedIssuesCount;
  final int pendingIssuesCount;
  final HealthCondition healthCondition;
  final double healthPercentage;
  final int totalSubscribers;

  const AreaHealthMetrics({
    required this.inProgressIssuesCount,
    required this.fixedIssuesCount,
    required this.pendingIssuesCount,
    required this.healthCondition,
    required this.healthPercentage,
    required this.totalSubscribers,
  });

  @override
  List<Object?> get props => [
    inProgressIssuesCount,
    fixedIssuesCount,
    pendingIssuesCount,
    healthCondition,
    healthPercentage,
  ];
}
