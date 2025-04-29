import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user_gender.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/complete_profile_use_case.dart';

part 'complete_profile_state.dart';
part 'complete_profile_cubit.freezed.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  final CompleteProfileUseCase _completeProfileUseCase;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  UserGender _selectedGender = UserGender.notSpecified;
  DateTime? _selectedDate;

  CompleteProfileCubit({required CompleteProfileUseCase completeProfileUseCase})
    : _completeProfileUseCase = completeProfileUseCase,
      super(const CompleteProfileState.initial());

  void updateGender(UserGender value) {
    state.maybeMap(
      initial: (currentState) {
        emit(
          CompleteProfileState.initial(
            gender: value,
            dateOfBirth: currentState.dateOfBirth,
          ),
        );
      },
      orElse: () {},
    );
    _selectedGender = value;
  }

  void updateDateOfBirth(DateTime value) {
    state.maybeMap(
      initial: (currentState) {
        emit(
          CompleteProfileState.initial(
            gender: currentState.gender,
            dateOfBirth: value,
          ),
        );
      },
      orElse: () {},
    );
    _selectedDate = value;
  }

  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  Future<void> submitProfile() async {
    if (!formKey.currentState!.validate()) return;
    emit(const CompleteProfileState.loading());
    final result = await _completeProfileUseCase.call(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      gender: _selectedGender,
      dateOfBirth: _selectedDate,
    );
    result.when(
      success: (session) => emit(CompleteProfileState.success(session)),
      failure: (error) => emit(CompleteProfileState.error(error)),
    );
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    return super.close();
  }
}
