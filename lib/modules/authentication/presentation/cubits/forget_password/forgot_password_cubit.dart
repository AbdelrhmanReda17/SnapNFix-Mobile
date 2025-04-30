import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/forgot_password_use_case.dart';

part 'forgot_password_state.dart';
part 'forgot_password_cubit.freezed.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordCubit({required ForgotPasswordUseCase forgotPasswordUseCase})
    : _forgotPasswordUseCase = forgotPasswordUseCase,
      super(const ForgotPasswordState.initial());

  final formKey = GlobalKey<FormState>();
  final emailOrPhoneController = TextEditingController();

  Future<void> emitForgotPasswordStates() async {
    if (!formKey.currentState!.validate()) return;

    emit(const ForgotPasswordState.loading());

    final response = await _forgotPasswordUseCase.call(
      emailOrPhoneNumber: emailOrPhoneController.text,
    );

    response.when(
      success: (authResult) {
        authResult.whenOrNull(
          requiresOtp: (phoneNumber, token, purpose) {
            emit(
              ForgotPasswordState.requiresOtp(
                phoneNumber: phoneNumber,
                verificationToken: token,
              ),
            );
          },
        );
      },
      failure: (error) => emit(ForgotPasswordState.error(error)),
    );
  }

  @override
  Future<void> close() {
    emailOrPhoneController.dispose();
    return super.close();
  }
}
