import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:snapnfix/modules/reports/domain/usecases/get_report_statistics_use_case.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/report_statistics_state.dart';
import 'package:snapnfix/modules/reports/data/models/report_statistics_model.dart';

@injectable
class ReportStatisticsCubit extends Cubit<ReportStatisticsState> {
  final GetReportStatisticsUseCase _getReportStatisticsUseCase;
  
  static const String _cacheKey = 'report_statistics_cache';

  ReportStatisticsCubit(this._getReportStatisticsUseCase)
      : super(const ReportStatisticsState());

  Future<void> loadStatistics() async {
    if (isClosed) return;

    await _loadCachedData();

    await _fetchFreshData();
  }

  Future<void> _loadCachedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedJson = prefs.getString(_cacheKey);
      
      if (cachedJson != null) {
        final cachedData = json.decode(cachedJson) as Map<String, dynamic>;
        final cachedStatistics = ReportStatisticsModel.fromJson(cachedData);
        
        if (!isClosed) {
          emit(state.copyWith(
            statistics: cachedStatistics,
            isLoading: false,
            error: null,
          ));
        }
      }
    } catch (e) {
      // If loading cached data fails, continue with fresh fetch
      // Don't emit error state as we'll try to fetch fresh data
    }
  }

  Future<void> _fetchFreshData() async {
    if (isClosed) return;
    if (state.statistics == null) {
      emit(state.copyWith(isLoading: true, error: null));
    }

    final result = await _getReportStatisticsUseCase.call();

    if (isClosed) return;

    result.when(
      success: (statistics) async {
        if (!isClosed) {
          await _cacheStatistics(statistics);
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
          if (state.statistics == null) {
            emit(state.copyWith(
              isLoading: false,
              error: error.message,
            ));
          } else {
            emit(state.copyWith(
              isLoading: false,
              error: null,
            ));
          }
        }
      },
    );
  }

  Future<void> _cacheStatistics(ReportStatisticsModel statistics) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(statistics.toJson());
      await prefs.setString(_cacheKey, jsonString);
    } catch (e) {
      // If caching fails, don't throw error, just continue
    }
  }

  void refresh() {
    loadStatistics();
  }
}
