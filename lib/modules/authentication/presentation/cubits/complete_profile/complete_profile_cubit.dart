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

  String _firstName = '';
  String _lastName = '';
  String _password = '';
  String _repeatPassword = '';

  final formKey = GlobalKey<FormState>();

  UserGender _selectedGender = UserGender.notSpecified;
  DateTime? _selectedDate;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get password => _password;
  String get repeatPassword => _repeatPassword;
  UserGender get selectedGender => _selectedGender;
  DateTime? get selectedDate => _selectedDate;

  CompleteProfileCubit({required CompleteProfileUseCase completeProfileUseCase})
    : _completeProfileUseCase = completeProfileUseCase,
      super(const CompleteProfileState.initial());

  void setFirstName(String value) {
    _firstName = value.trim();
  }

  void setLastName(String value) {
    _lastName = value.trim();
  }

  void setPassword(String value) {
    _password = value;
  }

  void setRepeatPassword(String value) {
    _repeatPassword = value;
  }

  void setSelectedGender(UserGender value) {
    _selectedGender = value;
  }

  void setSelectedDate(DateTime? value) {
    _selectedDate = value;
  }

  Future<void> submitProfile(String? pass) async {
    if (!_validateForm()) return;

    try {
      emit(const CompleteProfileState.loading());

      final result = await _completeProfileUseCase.call(
        firstName: _firstName,
        lastName: _lastName,
        password: pass ?? _password,
        gender: _selectedGender,
        dateOfBirth: _selectedDate,
      );

      result.when(
        success: _handleProfileCompletionSuccess,
        failure: _handleProfileCompletionFailure,
      );
    } catch (e) {
      emit(
        CompleteProfileState.error(
          ApiErrorModel(message: 'An unexpected error occurred'),
        ),
      );
    }
  }

  bool _validateForm() {
    if (!formKey.currentState!.validate()) {
      emit(
        CompleteProfileState.error(
          ApiErrorModel(message: 'Please fill in all required fields'),
        ),
      );
      return false;
    }

    if (_password != _repeatPassword) {
      emit(
        CompleteProfileState.error(
          ApiErrorModel(message: 'Passwords do not match'),
        ),
      );
      return false;
    }

    return true;
  }

  void _handleProfileCompletionSuccess(Session session) {
    emit(CompleteProfileState.success(session));
  }

  void _handleProfileCompletionFailure(ApiErrorModel error) {
    emit(CompleteProfileState.error(error));
  }
}
