import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/reset_password_use_case.dart';

part 'reset_password_state.dart';
part 'reset_password_cubit.freezed.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;

  ResetPasswordCubit({required ResetPasswordUseCase resetPasswordUseCase})
    : _resetPasswordUseCase = resetPasswordUseCase,
      super(const ResetPasswordState.initial());

  final formKey = GlobalKey<FormState>();

  String newPassword = "";
  String confirmPassword = "";

  void setNewPassword(String value) {
    newPassword = value;
  }

  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    emit(const ResetPasswordState.loading());

    await Future.delayed(const Duration(seconds: 2));

    final response = await _resetPasswordUseCase.call(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    response.when(
      success: (res) => emit(ResetPasswordState.success(res)),
      failure: (ApiErrorModel error) => emit(ResetPasswordState.error(error)),
    );
  }
}
