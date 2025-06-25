part of 'submit_fast_report_cubit.dart';

@freezed
class SubmitFastReportState with _$SubmitFastReportState {
  const factory SubmitFastReportState.initial() = _Initial;
  const factory SubmitFastReportState.loading() = _Loading;
  const factory SubmitFastReportState.success(bool success) = _Success;
  const factory SubmitFastReportState.error(ApiError error) = _Error;
}