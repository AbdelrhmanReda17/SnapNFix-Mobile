import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/request_otp_use_case.dart';

part 'forgot_password_state.dart';
part 'forgot_password_cubit.freezed.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final RequestOTPUseCase _requestOTPUseCase;

  ForgotPasswordCubit({required RequestOTPUseCase forgotPasswordUseCase})
    : _requestOTPUseCase = forgotPasswordUseCase,
      super(const ForgotPasswordState.initial());

  final formKey = GlobalKey<FormState>();

  String emailOrPhone = "";

  void setEmailOrPhone(String value) {
    emailOrPhone = value;
  }

  Future<void> emitForgotPasswordStates() async {
    if (!formKey.currentState!.validate()) return;

    emit(const ForgotPasswordState.loading());

    final response = await _requestOTPUseCase.call(
      phoneNumber: emailOrPhone,
      purpose: OtpPurpose.passwordReset,
    );

    response.when(
      success: (authResult) {
        authResult.whenOrNull(
          requiresOtp: (purpose) {
            emit(ForgotPasswordState.requiresOtp());
          },
        );
      },
      failure: (error) => emit(ForgotPasswordState.error(error)),
    );
  }
}
