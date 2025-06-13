import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/reports/data/models/snap_report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';
import 'package:snapnfix/modules/reports/domain/usecases/get_user_reports_use_case.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_filters/reports_sort_menu.dart';

part 'user_reports_cubit.freezed.dart';
part 'user_reports_cubit.g.dart';
part 'user_reports_state.dart';

class UserReportsCubit extends HydratedCubit<UserReportsState> {
  final GetUserReportsUseCase _getUserReportsUseCase;

  int _currentPage = 1;
  final int _pageSize = 10;
  ReportStatus? _status;
  IssueCategory? _category;
  SortOption _sortOption = SortOption.dateNewest;

  static const Duration _cacheValidDuration = Duration(minutes: 10);

  UserReportsCubit(this._getUserReportsUseCase)
    : super(const UserReportsState()) {
    debugPrint('UserReportsCubit initialized');
    _checkCacheValidity();
  }

  void _checkCacheValidity() {
    if (state.lastUpdated != null) {
      final now = DateTime.now();
      final difference = now.difference(state.lastUpdated!);

      if (difference > _cacheValidDuration) {
        debugPrint('Cache expired, clearing state');
        emit(
          state.copyWith(
            reports: [],
            lastUpdated: null,
            isLoading: true,
            hasReachedEnd: false,
          ),
        );
      } else {
        debugPrint('Using cached data, ${difference.inMinutes} minutes old');
        emit(state.copyWith(isLoading: false));
      }
    } else {
      emit(state.copyWith(hasReachedEnd: false, isLoading: true));
    }
  }

  bool get _isCacheValid {
    if (state.lastUpdated == null) return false;
    final now = DateTime.now();
    final difference = now.difference(state.lastUpdated!);
    return difference < _cacheValidDuration;
  }

  Future<void> loadReports({
    bool refresh = false,
    ReportStatus? status,
    IssueCategory? category,
    SortOption? sortOption,
    bool forceNetwork = false,
  }) async {
    debugPrint(
      'Loading reports - refresh: $refresh, forceNetwork: $forceNetwork',
    );
    try {
      // Update filters
      if (status != null) {
        _status = status;
      } else if (refresh) {
        _status = null;
      }

      if (category != null) {
        _category = category;
      } else if (refresh) {
        _category = null;
      }

      if (sortOption != null) _sortOption = sortOption;

      if (refresh) {
        _currentPage = 1;
      }

      // Check if we can use cached data
      if (!forceNetwork &&
          !refresh &&
          _isCacheValid &&
          state.reports.isNotEmpty &&
          state.currentStatus == _status &&
          state.currentCategory == _category &&
          state.currentSortOption == _sortOption) {
        debugPrint('Using valid cached data');
        return;
      }

      if (!refresh && state.hasReachedEnd) {
        debugPrint('Already reached end, skipping load');
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
          currentStatus: _status,
          currentCategory: _category,
          currentSortOption: _sortOption,
        ),
      );

      final categoryString = _category?.displayName;
      final statusString = _status?.value;

      debugPrint(
        'Fetching reports from network - page: $_currentPage, limit: $_pageSize',
      );

      final result = await _getUserReportsUseCase.call(
        status: statusString,
        category: categoryString,
        page: _currentPage,
        limit: _pageSize,
      );

      result.when(
        success: (response) {
          debugPrint(
            'Reports fetched successfully - count: ${response.key.length}',
          );
          final newReports = response.key;
          var sortedReports = _applySorting(newReports, _sortOption);
          final reachedEnd = response.value;

          final updatedReports =
              refresh
                  ? List<SnapReportModel>.from(sortedReports)
                  : [...state.reports, ...sortedReports];

          if (!reachedEnd && sortedReports.isNotEmpty) {
            _currentPage++;
          }

          emit(
            state.copyWith(
              reports: updatedReports,
              isLoading: false,
              isLoadingMore: false,
              hasReachedEnd: reachedEnd || sortedReports.isEmpty,
              error: null,
              lastUpdated: DateTime.now(),
            ),
          );

          debugPrint('State updated - total reports: ${updatedReports.length}');
        },
        failure: (error) {
          emit(
            state.copyWith(
              error: error,
              isLoading: false,
              isLoadingMore: false,
            ),
          );
          debugPrint('Error loading reports: ${error}');
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

  List<SnapReportModel> _applySorting(
    List<SnapReportModel> reports,
    SortOption option,
  ) {
    final sortedList = List<SnapReportModel>.from(reports);
    switch (option) {
      case SortOption.dateNewest:
        sortedList.sort((a, b) {
          if (a.createdAt == null && b.createdAt == null) return 0;
          if (a.createdAt == null) return 1;
          if (b.createdAt == null) return -1;
          return b.createdAt!.compareTo(a.createdAt!);
        });
        break;
      case SortOption.dateOldest:
        sortedList.sort((a, b) {
          if (a.createdAt == null && b.createdAt == null) return 0;
          if (a.createdAt == null) return 1;
          if (b.createdAt == null) return -1;
          return a.createdAt!.compareTo(b.createdAt!);
        });
        break;
    }
    return sortedList;
  }

  Future<void> clearFilters() async {
    _status = null;
    _category = null;
    _currentPage = 1;
    await loadReports(refresh: true);
  }

  Future<void> refreshReports() async {
    await loadReports(refresh: true, forceNetwork: true);
  }

  @override
  UserReportsState? fromJson(Map<String, dynamic> json) {
    try {
      return UserReportsState.fromJson(json);
    } catch (e) {
      debugPrint('Error deserializing state: $e');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(UserReportsState state) {
    try {
      return state.toJson();
    } catch (e) {
      debugPrint('Error serializing state: $e');
      return null;
    }
  }
}
