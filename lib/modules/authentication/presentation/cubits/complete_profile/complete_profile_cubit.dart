import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user_gender.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/complete_profile_use_case.dart';

part 'complete_profile_state.dart';
part 'complete_profile_cubit.freezed.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  final CompleteProfileUseCase _completeProfileUseCase;

  String firstName = '';
  String lastName = '';
  String password = '';
  String repeatPassword = '';

  final formKey = GlobalKey<FormState>();

  UserGender _selectedGender = UserGender.notSpecified;
  DateTime? _selectedDate;

  CompleteProfileCubit({required CompleteProfileUseCase completeProfileUseCase})
    : _completeProfileUseCase = completeProfileUseCase,
      super(const CompleteProfileState.initial());

  void setFirstName(String value) {
    firstName = value;
  }

  void setLastName(String value) {
    lastName = value;
  }

  void setPassword(String value) {
    password = value;
  }

  void setRepeatPassword(String value) {
    repeatPassword = value;
  }

  void selectedGender(UserGender selected) {
    _selectedGender = selected;
  }

  void selectedDate(DateTime? selected) {
    _selectedDate = selected;
  }

  Future<void> submitProfile(String? pass) async {
    if (!formKey.currentState!.validate()) return;
    emit(const CompleteProfileState.loading());
    final result = await _completeProfileUseCase.call(
      firstName: firstName,
      lastName: lastName,
      password: pass ?? password,
      gender: _selectedGender,
      dateOfBirth: _selectedDate,
    );
    result.when(
      success: (session) => emit(CompleteProfileState.success(session)),
      failure: (error) => emit(CompleteProfileState.error(error)),
    );
  }
}
