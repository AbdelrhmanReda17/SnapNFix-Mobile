import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/reports/domain/usecases/get_report_statistics_use_case.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/report_statistics_state.dart';

@injectable
class ReportStatisticsCubit extends Cubit<ReportStatisticsState> {
  final GetReportStatisticsUseCase _getReportStatisticsUseCase;

  ReportStatisticsCubit(this._getReportStatisticsUseCase)
      : super(const ReportStatisticsState());
  Future<void> loadStatistics() async {
    if (isClosed) return;
    
    emit(state.copyWith(isLoading: true, error: null));

    final result = await _getReportStatisticsUseCase.call();

    if (isClosed) return;

    result.when(
      success: (statistics) {
        if (!isClosed) {
          emit(state.copyWith(
            statistics: statistics,
            isLoading: false,
            lastUpdated: DateTime.now(),
            error: null,
          ));
        }
      },
      failure: (error) {
        if (!isClosed) {
          emit(state.copyWith(
            isLoading: false,
            error: error.message,
          ));
        }
      },
    );
  }

  void refresh() {
    loadStatistics();
  }
}
