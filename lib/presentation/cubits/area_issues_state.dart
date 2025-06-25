import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';

part 'area_issues_state.freezed.dart';

@freezed
abstract class AreaIssuesState with _$AreaIssuesState {
  const factory AreaIssuesState.initial() = _Initial;
  
  const factory AreaIssuesState.loading() = _Loading;
  
  const factory AreaIssuesState.loaded({
    required List<Issue> issues,
    required String areaName,
    @Default(false) bool isSubscribed,
    @Default([]) List<IssueStatus> selectedStatuses,
  }) = _Loaded;
  
  const factory AreaIssuesState.error(String message) = _Error;
} 