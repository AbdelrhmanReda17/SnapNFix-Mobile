// ignore_for_file: overridden_fields

import 'package:snapnfix/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/area_updates/data/models/area_issue_model.dart';

part 'area_details_model.g.dart';

@JsonSerializable()
class AreaDetailsModel extends AreaDetails {
  @override
  final List<AreaIssueModel> issues;
  @override
  final AreaHealthMetricsModel healthMetrics;
  @override
  final bool isSubscribed;
  @override
  final bool hasNext;
  @override
  final AreaInfoModel area;

  const AreaDetailsModel({
    required this.area,
    required this.issues,
    required this.healthMetrics,
    required this.isSubscribed,
    this.hasNext = false,
  }) : super(
         area,
         issues: issues,
         healthMetrics: healthMetrics,
         isSubscribed: isSubscribed,
         hasNext: hasNext,
       );

  factory AreaDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$AreaDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AreaDetailsModelToJson(this);
}
