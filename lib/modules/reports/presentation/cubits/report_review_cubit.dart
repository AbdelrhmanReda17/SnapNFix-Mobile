import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';
import 'package:snapnfix/modules/reports/domain/usecases/get_user_reports_use_case.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_filters/reports_sort_menu.dart';

part 'report_review_state.dart';
part 'report_review_cubit.freezed.dart';

class ReportReviewCubit extends Cubit<ReportReviewState> {
  final GetUserReportsUseCase _getUserReportsUseCase;

  int _currentPage = 1;
  final int _pageSize = 10;
  ReportStatus? _status;
  IssueCategory? _category;
  SortOption _sortOption = SortOption.dateNewest;

  ReportReviewCubit(this._getUserReportsUseCase)
    : super(const ReportReviewState()) {
    debugPrint('ReportReviewCubit initialized');
    // loadReports();
  }

  Future<void> loadReports({
    bool refresh = false,
    ReportStatus? status,
    IssueCategory? category,
    SortOption? sortOption,
  }) async {
    debugPrint('Loading reports - refresh: $refresh');
    try {
      if (status != null || status == null && _status != null) _status = status;
      if (category != null || category == null && _category != null) _category = category;
      if (sortOption != null) _sortOption = sortOption;


      if (refresh) {
        _currentPage = 1;
      }

      final isFirstLoad = state.reports.isEmpty && !refresh;
      final isPagination = !refresh && state.reports.isNotEmpty;

      final categoryString = _category?.displayName;
      final statusString = _status?.value;

      emit(
        state.copyWith(
          reports: refresh ? [] : state.reports,
          isLoading: isFirstLoad || refresh,
          isLoadingMore: isPagination,
          hasReachedEnd: false,
          error: null,
          currentStatus: _status,
          currentCategory: _category,
          currentSortOption: _sortOption,
        ),
      );

      debugPrint('Fetching reports - page: $_currentPage, limit: $_pageSize');

      final result = await _getUserReportsUseCase.call(
        status: statusString,
        category: categoryString,
        page: _currentPage,
        limit: _pageSize,
      );

      result.when(
        success: (newReports) {
          debugPrint('Received ${newReports.length} reports');

          var sortedReports = _applySorting(newReports, _sortOption);
          final reachedEnd = sortedReports.length < _pageSize;

          final updatedReports = refresh
              ? List<ReportModel>.from(sortedReports)
              : [...state.reports, ...sortedReports];

          if (!reachedEnd) {
            _currentPage++;
          }

          emit(
            state.copyWith(
              reports: updatedReports,
              isLoading: false,
              isLoadingMore: false,
              hasReachedEnd: reachedEnd,
              error: null,
            ),
          );

          debugPrint('State updated - total reports: ${updatedReports.length}');
        },
        failure: (error) {
          emit(
            state.copyWith(
              error: error.message,
              isLoading: false,
              isLoadingMore: false,
            ),
          );
          debugPrint('Error loading reports: ${error.message}');
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: e.toString(),
          isLoading: false,
          isLoadingMore: false,
        ),
      );
    }
  }

  Future<void> refreshReports() async {
    await loadReports(refresh: true);
  }

  List<ReportModel> _applySorting(List<ReportModel> reports, SortOption option) {
    final sortedList = List<ReportModel>.from(reports);
    switch (option) {
      case SortOption.dateNewest:
        sortedList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        break;
      case SortOption.dateOldest:
        sortedList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        break;
    }
    return sortedList;
  }

  // Apply filters with enum values
  Future<void> applyFilters({
    ReportStatus? status,
    IssueCategory? category,
  }) async {
    await loadReports(refresh: true, status: status, category: category);
  }

  Future<void> applySorting(SortOption option) async {
    await loadReports(
      refresh: true,
      sortOption: option,
    );
  }

  // Clear all filters
  Future<void> clearFilters() async {
    _status = null;
    _category = null;

    await loadReports(refresh: true);
  }
}
