import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/features/settings/data/models/ChangePasswordDTO.dart';
import 'package:snapnfix/features/settings/data/repos/change_password_repository.dart';

part 'change_password_state.dart';
part 'change_password_cubit.freezed.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordRepository _changePasswordRepository;
  ChangePasswordCubit(this._changePasswordRepository)
    : super(ChangePasswordState.initial());

  final formKey = GlobalKey<FormState>();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final oldPasswordVisible = ValueNotifier<bool>(false);
  final newPasswordVisible = ValueNotifier<bool>(false);
  final confirmPasswordVisible = ValueNotifier<bool>(false);

  void toggleOldPasswordVisibility() {
    oldPasswordVisible.value = !oldPasswordVisible.value;
  }

  void toggleNewPasswordVisibility() {
    newPasswordVisible.value = !newPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisible.value = !confirmPasswordVisible.value;
  }

  void emitChangePasswordState() async {
    emit(const ChangePasswordState.loading());
    final response = await _changePasswordRepository.changePassword(
      ChangePasswordDTO(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      ),
    );
    response.when(
      success: (data) {
        emit(ChangePasswordState.success(data));
      },
      failure: (error) {
        emit(ChangePasswordState.error(error: error));
      },
    );
  }

  @override
  Future<void> close() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    oldPasswordVisible.dispose();
    newPasswordVisible.dispose();
    confirmPasswordVisible.dispose();
    return super.close();
  }
}
