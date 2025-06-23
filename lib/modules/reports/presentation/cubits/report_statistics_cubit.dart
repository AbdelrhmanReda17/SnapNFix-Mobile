import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/infrastructure/storage/shared_preferences_service.dart';
import 'dart:convert';
import 'package:snapnfix/modules/reports/domain/usecases/get_report_statistics_use_case.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/report_statistics_state.dart';
import 'package:snapnfix/modules/reports/data/models/report_statistics_model.dart';

@injectable
class ReportStatisticsCubit extends Cubit<ReportStatisticsState> {
  final GetReportStatisticsUseCase _getReportStatisticsUseCase;
  final String userId =
      getIt<ApplicationConfigurations>().currentSession?.user.phoneNumber ?? '';
  late final String _cacheKey;

  static const _cacheDuration = Duration(minutes: 1);

  ReportStatisticsCubit(this._getReportStatisticsUseCase)
    : super(const ReportStatisticsState()) {
    _cacheKey = 'user_report_statistics_$userId';
  }

  Future<void> loadStatistics() async {
    if (isClosed) return;
    await _loadCachedData();
    await _fetchFreshDataIfNeeded();
  }

  Future<void> _loadCachedData() async {
    try {
      final prefs = getIt<SharedPreferencesService>();
      final cachedJson = prefs.getString(_cacheKey);

      final cachedData = json.decode(cachedJson) as Map<String, dynamic>;
      final cachedStatistics = ReportStatisticsModel.fromJson(cachedData);

      if (!isClosed) {
        emit(
          state.copyWith(
            statistics: cachedStatistics,
            isLoading: false,
            error: null,
          ),
        );
      }
    } catch (e) {
      // If loading cached data fails, continue with fresh fetch
      // Don't emit error state as we'll try to fetch fresh data
    }
  }

  Future<void> _fetchFreshDataIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final lastFetchMillis = prefs.getInt('$_cacheKey:lastFetch') ?? 0;
    final lastFetch = DateTime.fromMillisecondsSinceEpoch(lastFetchMillis);
    final now = DateTime.now();

    if (now.difference(lastFetch) > _cacheDuration) {
      await _fetchFreshData();
      await prefs.setInt('$_cacheKey:lastFetch', now.millisecondsSinceEpoch);
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
        if (isClosed) return;
        await _cacheStatistics(statistics);
        emit(
          state.copyWith(
            statistics: statistics,
            isLoading: false,
            lastUpdated: DateTime.now(),
            error: null,
          ),
        );
      },
      failure: (error) {
        if (isClosed) return;
        if (state.statistics == null) {
          emit(state.copyWith(isLoading: false, error: error.message));
        } else {
          emit(state.copyWith(isLoading: false, error: null));
        }
      },
    );
  }

  Future<void> _cacheStatistics(ReportStatisticsModel statistics) async {
    try {
      final prefs = getIt<SharedPreferencesService>();
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
