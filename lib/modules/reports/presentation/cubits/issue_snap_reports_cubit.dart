import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:snapnfix/modules/reports/data/models/snap_report_model.dart';
import 'package:snapnfix/modules/reports/domain/usecases/get_issue_snap_reports_use_case.dart';

part 'issue_snap_reports_cubit.freezed.dart';
part 'issue_snap_reports_cubit.g.dart';
part 'issue_snap_reports_state.dart';

class IssueSnapReportsCubit extends Cubit<IssueSnapReportsState> {
  final GetIssueSnapReportsUseCase _getIssueSnapReportsUseCase;

  int _currentPage = 1;
  final int _pageSize = 10;
  String? _currentIssueId;

  IssueSnapReportsCubit(this._getIssueSnapReportsUseCase)
    : super(const IssueSnapReportsState());
  Future<void> loadReports({
    required String issueId,
    bool refresh = false,
    String? sort,
  }) async {
    if (isClosed) return;
    
    try {
      // Reset if different issue
      if (_currentIssueId != issueId) {
        _currentIssueId = issueId;
        _currentPage = 1;
        refresh = true;
      }

      if (refresh) {
        _currentPage = 1;
      }

      if (!refresh && state.hasReachedEnd) {
        return;
      }

      final isFirstLoad = state.reports.isEmpty && !refresh;
      final isPagination = !refresh && state.reports.isNotEmpty;

      emit(
        state.copyWith(
          reports: refresh ? [] : state.reports,
          isLoading: isFirstLoad || refresh,
          isLoadingMore: isPagination,
          hasReachedEnd: refresh ? false : state.hasReachedEnd,
          error: null,
        ),
      );

      final result = await _getIssueSnapReportsUseCase.call(
        issueId: issueId,
        sort: sort,
        page: _currentPage,
        limit: _pageSize,
      );

      if (isClosed) return;

      result.when(
        success: (newReports) {
          if (isClosed) return;
          final hasNextPage = newReports.value;
          final hasReachedEnd = !hasNextPage;
          
          final updatedReports =
              refresh
                  ? List<SnapReportModel>.from(newReports.key)
                  : [...state.reports, ...newReports.key];

          if (hasNextPage && newReports.key.isNotEmpty) {
            _currentPage++;
          }

          emit(
            state.copyWith(
              reports: updatedReports,
              isLoading: false,
              isLoadingMore: false,
              hasReachedEnd: hasReachedEnd,
              error: null,
            ),
          );
        },
        failure: (error) {
          if (isClosed) return;
          emit(
            state.copyWith(
              error: error,
              isLoading: false,
              isLoadingMore: false,
            ),
          );
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          error: e.toString(),
          isLoading: false,
          isLoadingMore: false,
        ),
      );
    }
  }
  Future<void> refreshReports(String issueId) async {
    if (isClosed) return;
    await loadReports(issueId: issueId, refresh: true);
  }
}
