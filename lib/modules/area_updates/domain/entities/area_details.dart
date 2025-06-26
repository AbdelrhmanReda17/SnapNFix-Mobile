import 'package:snapnfix/index.dart';

class AreaDetails {
  final AreaInfo area;
  final List<AreaIssue> issues;
  final AreaHealthMetrics healthMetrics;
  final bool hasNext;
  final bool isSubscribed;

  const AreaDetails(
    this.area, {
    required this.issues,
    required this.healthMetrics,
    required this.isSubscribed,
    this.hasNext = false,
  });
}
