import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/usecases/submit_fast_report_use_case.dart';

part 'submit_fast_report_state.dart';
part 'submit_fast_report_cubit.freezed.dart';

class SubmitFastReportCubit extends Cubit<SubmitFastReportState> {
  final SubmitFastReportUseCase _submitFastReportUseCase;

  SubmitFastReportCubit(this._submitFastReportUseCase)
      : super(const SubmitFastReportState.initial());

  Future<void> submitFastReport({
    required String issueId,
    required String comment,
    required ReportSeverity severity,
  }) async {
    emit(const SubmitFastReportState.loading());

    final result = await _submitFastReportUseCase.call(
      issueId: issueId,
      comment: comment,
      severity: severity,
    );

    result.when(
      success: (data) {
        emit(SubmitFastReportState.success(data));
      },
      failure: (error) {
        emit(SubmitFastReportState.error(error));
      },
    );
  }

  void reset() {
    emit(const SubmitFastReportState.initial());
  }
}