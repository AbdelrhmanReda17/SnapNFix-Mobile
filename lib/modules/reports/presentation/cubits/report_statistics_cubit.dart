import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
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
      getIt<ApplicationConfigurations>().currentSession?.user.phoneNumber ??
      getIt<ApplicationConfigurations>().currentSession?.user.email ??
      'default_user';
  late final String _cacheKey;

  static const _cacheDuration = Duration(minutes: 0);

  ReportStatisticsCubit(this._getReportStatisticsUseCase)
    : super(const ReportStatisticsState()) {
    _cacheKey = 'user_report_statistics_$userId';
  }

  Future<void> _cacheStatistics(ReportStatisticsModel statistics) async {
    try {
      final prefs = getIt<SharedPreferencesService>();
      final jsonString = json.encode(statistics.toJson());
      final now = DateTime.now();
      await prefs.setInt('$_cacheKey:lastFetch', now.millisecondsSinceEpoch);
      await prefs.setString(_cacheKey, jsonString);
    } catch (e) {
      // If caching fails, don't throw error, just continue
    }
  }

  Future<void> loadStatistics() async {
    if (isClosed) return;
    await _loadCachedData();
  }

  Future<void> _loadCachedData() async {
    try {
      final prefs = getIt<SharedPreferencesService>();
      final cachedJson = prefs.getString(_cacheKey);
      if (cachedJson.isEmpty) {
        await _fetchFreshData();
        return;
      }
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
        await _fetchFreshDataIfNeeded();
      }
    } catch (e) {
      await _fetchFreshData();
    }
  }

  Future<void> _fetchFreshDataIfNeeded() async {
    final prefs = getIt<SharedPreferencesService>();
    final lastFetchMillis = prefs.getInt('$_cacheKey:lastFetch');
    final lastFetch = DateTime.fromMillisecondsSinceEpoch(lastFetchMillis);
    final now = DateTime.now();
    if (now.difference(lastFetch) > _cacheDuration) {
      await _fetchFreshData();
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
        if (state.statistics != null) {
        } else {
          emit(state.copyWith(isLoading: false, error: error.message));
        }
      },
    );
  }

  void refresh() {
    loadStatistics();
  }
}
