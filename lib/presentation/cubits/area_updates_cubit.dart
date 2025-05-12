import 'package:flutter_bloc/flutter_bloc.dart';
import 'area_updates_state.dart';

class AreaUpdatesCubit extends Cubit<AreaUpdatesState> {
  AreaUpdatesCubit() : super(AreaUpdatesState.initial());

  void selectArea(String area) {
    emit(state.copyWith(selectedArea: area));
  }
} 