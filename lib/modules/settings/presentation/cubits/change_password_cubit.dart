import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/settings/data/models/dtos/change_password_dto.dart';
import 'package:snapnfix/modules/settings/domain/usecases/change_password_use_case.dart';

part 'change_password_state.dart';
part 'change_password_cubit.freezed.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit({required ChangePasswordUseCase changePasswordUseCase})
    : _changePasswordUseCase = changePasswordUseCase,
      super(const ChangePasswordState.initial());

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
    if (!formKey.currentState!.validate()) return;

    emit(const ChangePasswordState.loading());

    final response = await _changePasswordUseCase(
      ChangePasswordDTO(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      ),
    );

    response.when(
      success: (data) => emit(ChangePasswordState.success(data)),
      failure:
          (error) => emit(ChangePasswordState.error(error: error.toString())),
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
