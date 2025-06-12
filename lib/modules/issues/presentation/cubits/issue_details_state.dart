part of 'issue_details_cubit.dart';

@freezed
class IssueDetailsState with _$IssueDetailsState {
  const factory IssueDetailsState.initial() = _Initial;
  const factory IssueDetailsState.loading() = _Loading;
  const factory IssueDetailsState.loaded(Issue issue) = _Loaded;
  const factory IssueDetailsState.error(ApiError error) = _Error;
}
