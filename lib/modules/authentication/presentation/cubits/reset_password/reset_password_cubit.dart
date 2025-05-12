import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/reset_password_use_case.dart';

part 'reset_password_state.dart';
part 'reset_password_cubit.freezed.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;

  final formKey = GlobalKey<FormState>();

  String _newPassword = "";
  String _confirmPassword = "";

  String get newPassword => _newPassword;
  String get confirmPassword => _confirmPassword;

  ResetPasswordCubit({required ResetPasswordUseCase resetPasswordUseCase})
    : _resetPasswordUseCase = resetPasswordUseCase,
      super(const ResetPasswordState.initial());

  void setNewPassword(String value) {
    _newPassword = value;
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
  }

  Future<void> resetPassword() async {
    if (!_validateForm()) return;

    try {
      emit(const ResetPasswordState.loading());

      final response = await _resetPasswordUseCase.call(
        newPassword: _newPassword,
        confirmPassword: _confirmPassword,
      );

      response.when(
        success: _handleResetPasswordSuccess,
        failure: _handleResetPasswordFailure,
      );
    } catch (e) {
      emit(
        ResetPasswordState.error(
          ApiErrorModel(message: 'An unexpected error occurred'),
        ),
      );
    }
  }

  bool _validateForm() {
    if (!formKey.currentState!.validate()) {
      emit(
        ResetPasswordState.error(
          ApiErrorModel(message: 'Please fill in all required fields'),
        ),
      );
      return false;
    }

    if (_newPassword != _confirmPassword) {
      emit(
        ResetPasswordState.error(
          ApiErrorModel(message: 'Passwords do not match'),
        ),
      );
      return false;
    }

    if (_newPassword.length < 8) {
      emit(
        ResetPasswordState.error(
          ApiErrorModel(message: 'Password must be at least 8 characters long'),
        ),
      );
      return false;
    }

    return true;
  }

  void _handleResetPasswordSuccess(bool result) {
    emit(ResetPasswordState.success(result));
  }

  void _handleResetPasswordFailure(ApiErrorModel error) {
    emit(ResetPasswordState.error(error));
  }
}
