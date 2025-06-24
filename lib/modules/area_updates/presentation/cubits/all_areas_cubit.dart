import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_all_areas_use_case.dart';
import 'package:snapnfix/core/index.dart';
import 'all_areas_state.dart';

class AllAreasCubit extends Cubit<AllAreasState> {
  final GetAllAreasUseCase _getAllAreasUseCase;

  AllAreasCubit({
    required GetAllAreasUseCase getAllAreasUseCase,
  }) : _getAllAreasUseCase = getAllAreasUseCase,
       super(const AllAreasState.initial());

  Future<void> fetchAllAreas() async {
    try {
      if (isClosed) return;
      emit(const AllAreasState.loading());

      final result = await _getAllAreasUseCase.call();

      if (isClosed) return;
      result.when(
        success: (areas) => emit(AllAreasState.loaded(areas)),
        failure: (error) => emit(AllAreasState.error(error)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(AllAreasState.error(ApiError(message: 'An unexpected error occurred')));
    }
  }

  Future<void> refreshAreas() async {
    await fetchAllAreas();
  }
}
