part of 'user_reports_cubit.dart';

@freezed
class UserReportsState with _$UserReportsState {
  const factory UserReportsState({
    @Default([]) List<SnapReportModel> reports,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasReachedEnd,
    String? error,
    ReportStatus? currentStatus,
    IssueCategory? currentCategory,
    @Default(SortOption.dateNewest) SortOption currentSortOption,
    DateTime? lastUpdated,
  }) = _UserReportsState;

  factory UserReportsState.fromJson(Map<String, dynamic> json) =>
      _$UserReportsStateFromJson(json);
}
