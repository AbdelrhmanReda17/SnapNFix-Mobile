import 'package:flutter_flutter_bloc/flutter_flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

part 'report_review_state.dart';
part 'report_review_cubit.freezed.dart';

class ReportReviewCubit extends Cubit<ReportReviewState> {
  final BaseReportRepository _repository;

  ReportReviewCubit(this._repository) : super(const ReportReviewState()) {
    _setupReportsListener();
  }

  void _setupReportsListener() {
    emit(state.copyWith(isLoading: true));
    emit(state.copyWith(reports: [], isLoading: false));
  }
}
