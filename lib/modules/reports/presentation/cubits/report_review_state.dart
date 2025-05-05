part of 'report_review_cubit.dart';

@freezed
class ReportReviewState with _$ReportReviewState {
  const factory ReportReviewState({
    @Default([]) List<ReportModel> reports,
    @Default(true) bool isLoading,
    String? error,
  }) = _ReportReviewState;
}