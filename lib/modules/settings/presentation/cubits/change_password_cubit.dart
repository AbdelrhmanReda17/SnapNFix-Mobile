import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/settings/data/models/change_password_request.dart';
import 'package:snapnfix/modules/settings/domain/usecases/change_password_use_case.dart';

part 'change_password_state.dart';
part 'change_password_cubit.freezed.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit({required ChangePasswordUseCase changePasswordUseCase})
    : _changePasswordUseCase = changePasswordUseCase,
      super(const ChangePasswordState.initial());

  final formKey = GlobalKey<FormState>();

  String oldPassword = "";
  String newPassword = "";
  String confirmPassword = "";

  void setOldPassword(String value) {
    oldPassword = value;
  }

  void setNewPassword(String value) {
    newPassword = value;
  }

  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  void emitChangePasswordState() async {
    if (!formKey.currentState!.validate()) return;

    emit(const ChangePasswordState.loading());

    final response = await _changePasswordUseCase(
      ChangePasswordRequest(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      ),
    );

    response.when(
      success: (data) => emit(ChangePasswordState.success(data)),
      failure:
          (error) => emit(ChangePasswordState.error(error: error.toString())),
    );
  }
}
