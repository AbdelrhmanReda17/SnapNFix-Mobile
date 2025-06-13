part of 'issue_fast_reports_cubit.dart';

@freezed
class IssueFastReportsState with _$IssueFastReportsState {
  const factory IssueFastReportsState({
    @Default([]) List<FastReportModel> reports,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasReachedEnd,
    String? error,
  }) = _IssueFastReportsState;

  factory IssueFastReportsState.fromJson(Map<String, dynamic> json) =>
      _$IssueFastReportsStateFromJson(json);
}
