import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_area_health_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_health_metrics.dart';
import 'package:snapnfix/core/index.dart';

part 'area_health_state.dart';
part 'area_health_cubit.freezed.dart';

class AreaHealthCubit extends Cubit<AreaHealthState> {
  final GetAreaHealthUseCase _getAreaHealthUseCase;

  AreaHealthCubit({
    required GetAreaHealthUseCase getAreaHealthUseCase,
  }) : _getAreaHealthUseCase = getAreaHealthUseCase,
       super(const AreaHealthState.initial());

  Future<void> loadAreaHealth(String areaName) async {
    if (areaName.trim().isEmpty) {
      if (isClosed) return;
      emit(AreaHealthState.error(ApiError(message: 'Area name cannot be empty')));
      return;
    }

    try {
      if (isClosed) return;
      emit(const AreaHealthState.loading());

      final result = await _getAreaHealthUseCase.call(areaName);

      if (isClosed) return;
      result.when(
        success: (healthMetrics) {
          if (isClosed) return;
          emit(AreaHealthState.loaded(healthMetrics));
        },
        failure: (error) {
          if (isClosed) return;
          emit(AreaHealthState.error(error));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(AreaHealthState.error(ApiError(message: 'An unexpected error occurred')));
    }
  }

  Future<void> refreshAreaHealth(String areaName) async {
    await loadAreaHealth(areaName);
  }

  void reset() {
    if (isClosed) return;
    emit(const AreaHealthState.initial());
  }
}
