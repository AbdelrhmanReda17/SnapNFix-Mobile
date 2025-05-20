part of 'report_review_cubit.dart';

@freezed
class ReportReviewState with _$ReportReviewState {
  const factory ReportReviewState({
    @Default([]) List<ReportModel> reports,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasReachedEnd,
    String? error,
    ReportStatus? currentStatus,
    IssueCategory? currentCategory,
    @Default(SortOption.dateNewest) SortOption currentSortOption,
  }) = _ReportReviewState;
}