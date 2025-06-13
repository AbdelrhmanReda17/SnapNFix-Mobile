part of 'issue_snap_reports_cubit.dart';
@freezed
class IssueSnapReportsState with _$IssueSnapReportsState {
  const factory IssueSnapReportsState({
    @Default([]) List<SnapReportModel> reports,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasReachedEnd,
    String? error,
  }) = _IssueSnapReportsState;

  factory IssueSnapReportsState.fromJson(Map<String, dynamic> json) =>
      _$IssueSnapReportsStateFromJson(json);
}
