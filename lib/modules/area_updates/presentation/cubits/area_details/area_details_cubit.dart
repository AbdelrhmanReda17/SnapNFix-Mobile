import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_all_area_details.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_details.dart';
import 'package:snapnfix/core/index.dart';

part 'area_details_state.dart';
part 'area_details_cubit.freezed.dart';

class AreaDetailsCubit extends Cubit<AreaDetailsState> {
  final GetAreaDetailsUseCase _getAreaDetailsUseCase;

  AreaDetailsCubit({
    required GetAreaDetailsUseCase getAreaDetailsUseCase,
  }) : _getAreaDetailsUseCase = getAreaDetailsUseCase,
       super(const AreaDetailsState.initial());

  Future<void> loadAreaDetails({
    required String areaName,
    int page = 1,
    int limit = 20,
  }) async {
    if (areaName.trim().isEmpty) {
      emit(AreaDetailsState.error(ApiError(message: 'Area name cannot be empty')));
      return;
    }

    try {
      if (isClosed) return;
      emit(const AreaDetailsState.loading());

      final result = await _getAreaDetailsUseCase.call(
        areaName: areaName,
        page: page,
        limit: limit,
      );

      if (isClosed) return;
      result.when(
        success: (areaDetails) => emit(AreaDetailsState.loaded(areaDetails)),
        failure: (error) => emit(AreaDetailsState.error(error)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(AreaDetailsState.error(ApiError(message: 'An unexpected error occurred')));
    }
  }

  Future<void> refreshAreaDetails({
    required String areaName,
    int page = 1,
    int limit = 20,
  }) async {
    await loadAreaDetails(
      areaName: areaName,
      page: page,
      limit: limit,
    );
  }

  void reset() {
    emit(const AreaDetailsState.initial());
  }
}
