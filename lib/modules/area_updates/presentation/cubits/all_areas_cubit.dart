import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';
import 'all_areas_state.dart';

class AllAreasCubit extends Cubit<AllAreasState> {
  final BaseAreaUpdatesRepository _repository;

  AllAreasCubit(this._repository) : super(const AllAreasState.initial());

  Future<void> fetchAllAreas() async {
    emit(const AllAreasState.loading());

    final result = await _repository.getAllAreas();

    result.when(
      success: (areas) => emit(AllAreasState.loaded(areas)),
      failure: (error) => emit(AllAreasState.error(error.message)),
    );
  }

  Future<void> refreshAreas() async {
    await fetchAllAreas();
  }
}
