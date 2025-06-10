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
      // Fix: Proper filter assignment logic
      if (status != null) {
        _status = status;
      } else if (refresh) {
        // Clear status on refresh if not explicitly provided
        _status = null;
      }

      if (category != null) {
        _category = category;
      } else if (refresh) {
        // Clear category on refresh if not explicitly provided
        _category = null;
      }

      if (sortOption != null) _sortOption = sortOption;

      if (refresh) {
        _currentPage = 1;
      }

      // Fix: Prevent loading more when already reached end
      if (!refresh && state.hasReachedEnd) {
        debugPrint('Already reached end, skipping load');
        return;
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
          hasReachedEnd:
              refresh
                  ? false
                  : state
                      .hasReachedEnd, // Fix: Don't reset hasReachedEnd for pagination
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
        success: (response) {
          final newReports = response.key;
          var sortedReports = _applySorting(newReports, _sortOption);
          final reachedEnd = response.value;

          // Fix: Handle duplicate reports during pagination
          final updatedReports =
              refresh
                  ? List<ReportModel>.from(sortedReports)
                  : [...state.reports, ...sortedReports];

          // Fix: Only increment page if we haven't reached the end AND got new data
          if (!reachedEnd && sortedReports.isNotEmpty) {
            _currentPage++;
          }

          emit(
            state.copyWith(
              reports: updatedReports,
              isLoading: false,
              isLoadingMore: false,
              hasReachedEnd:
                  reachedEnd ||
                  sortedReports
                      .isEmpty, // Fix: Also consider empty response as end
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
      debugPrint('Exception in loadReports: $e');
    }
  }

  // Add this helper method to prevent duplicates
  List<ReportModel> _mergeDeduplicated(
    List<ReportModel> existing,
    List<ReportModel> newReports,
  ) {
    final existingIds = existing.map((r) => r.id).toSet();
    final uniqueNewReports =
        newReports.where((r) => !existingIds.contains(r.id)).toList();
    return [...existing, ...uniqueNewReports];
  }

  List<ReportModel> _applySorting(
    List<ReportModel> reports,
    SortOption option,
  ) {
    final sortedList = List<ReportModel>.from(reports);
    switch (option) {
      case SortOption.dateNewest:
        sortedList.sort((a, b) {
          // Fix: Add null safety for createdAt comparison
          if (a.createdAt == null && b.createdAt == null) return 0;
          if (a.createdAt == null) return 1;
          if (b.createdAt == null) return -1;
          return b.createdAt!.compareTo(a.createdAt!);
        });
        break;
      case SortOption.dateOldest:
        sortedList.sort((a, b) {
          // Fix: Add null safety for createdAt comparison
          if (a.createdAt == null && b.createdAt == null) return 0;
          if (a.createdAt == null) return 1;
          if (b.createdAt == null) return -1;
          return a.createdAt!.compareTo(b.createdAt!);
        });
        break;
    }
    return sortedList;
  }

  // Fix: Reset state properly when clearing filters
  Future<void> clearFilters() async {
    _status = null;
    _category = null;
    _currentPage = 1; // Reset pagination

    await loadReports(refresh: true);
  }
}
