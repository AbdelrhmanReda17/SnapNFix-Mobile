part of 'submit_report_cubit.dart';

@freezed
class SubmitReportState with _$SubmitReportState {
  const factory SubmitReportState({
    required File? image,
    required ReportSeverity severity,
    required Position? position,
    required bool isLoading,
    required String? details,
    String? error,
    String? successMessage,
  }) = _SubmitReportState;

  factory SubmitReportState.initial() => SubmitReportState(
    image: File(''),
    severity: ReportSeverity.low,
    position: null,
    isLoading: false,
    details: null,
    error: null,
    successMessage: null,
  );
}
