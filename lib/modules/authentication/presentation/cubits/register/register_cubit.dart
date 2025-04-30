import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/register_use_case.dart';

part 'register_state.dart';
part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  bool get passwordVisible => state.maybeMap(
    initial: (state) => state.passwordVisible,
    orElse: () => false,
  );
  bool get confirmPasswordVisible => state.maybeMap(
    initial: (state) => state.confirmPasswordVisible,
    orElse: () => false,
  );

  RegisterCubit({required RegisterUseCase registerUseCase})
    : _registerUseCase = registerUseCase,
      super(const RegisterState.initial());

  void togglePasswordVisibility() {
    state.maybeMap(
      initial: (state) {
        emit(
          RegisterState.initial(
            passwordVisible: !state.passwordVisible,
            confirmPasswordVisible: state.confirmPasswordVisible,
          ),
        );
      },
      orElse: () {},
    );
  }

  void toggleConfirmPasswordVisibility() {
    state.maybeMap(
      initial: (state) {
        emit(
          RegisterState.initial(
            passwordVisible: state.passwordVisible,
            confirmPasswordVisible: !state.confirmPasswordVisible,
          ),
        );
      },
      orElse: () {},
    );
  }

  Future<void> emitRegisterStates() async {
    if (!formKey.currentState!.validate()) return;

    emit(const RegisterState.loading());

    final response = await _registerUseCase.call(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phoneNumber: phoneController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    response.when(
      success: (authResult) {
        authResult.whenOrNull(
          requiresOtp: (phoneNumber, token, purpose) {
            emit(
              RegisterState.requiresOtp(
                phoneNumber: phoneNumber,
                verificationToken: token,
              ),
            );
          },
        );
      },
      failure: (error) => emit(RegisterState.error(error)),
    );
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    return super.close();
  }
}
