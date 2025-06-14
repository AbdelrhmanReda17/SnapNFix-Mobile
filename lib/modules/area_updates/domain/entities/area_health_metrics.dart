import 'package:equatable/equatable.dart';

class AreaHealthMetrics extends Equatable {
  final int totalIssues;
  final int openIssues;
  final int closedIssues;
  final int resolvedIssues;
  final double areaHealthScore;

  const AreaHealthMetrics({
    required this.totalIssues,
    required this.openIssues,
    required this.closedIssues,
    required this.resolvedIssues,
    required this.areaHealthScore,
  });

  @override
  List<Object?> get props => [
    totalIssues,
    openIssues,
    closedIssues,
    resolvedIssues,
    areaHealthScore,
  ];
}
