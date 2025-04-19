part of 'add_report_cubit.dart';

@freezed
class AddReportState<T> with _$AddReportState<T> {
  const factory AddReportState.initial() = _Initial;

  const factory AddReportState.loading() = Loading;
  const factory AddReportState.success(T data) = Success<T>;
  const factory AddReportState.error({required String error}) = Error;
}
