import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/authentication/index.dart';
import 'package:snapnfix/core/index.dart';

part 'forgot_password_state.dart';
part 'forgot_password_cubit.freezed.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final RequestOTPUseCase _requestOTPUseCase;

  final formKey = GlobalKey<FormState>();

  String _emailOrPhone = "";

  String get emailOrPhone => _emailOrPhone;

  ForgotPasswordCubit({required RequestOTPUseCase forgotPasswordUseCase})
    : _requestOTPUseCase = forgotPasswordUseCase,
      super(const ForgotPasswordState.initial());

  void setEmailOrPhone(String value) {
    _emailOrPhone = value.trim();
  }

  Future<void> requestPasswordReset() async {
    if (!_validateForm()) return;

    try {
      emit(const ForgotPasswordState.loading());

      final response = await _requestOTPUseCase.call(
        phoneNumber: _emailOrPhone,
        purpose: OtpPurpose.passwordReset,
      );

      response.when(
        success: _handleRequestSuccess,
        failure: _handleRequestFailure,
      );
    } catch (e) {
      emit(
        ForgotPasswordState.error(
          ApiError(message: 'An unexpected error occurred'),
        ),
      );
    }
  }

  bool _validateForm() {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    return true;
  }

  void _handleRequestSuccess(AuthenticationResult result) {
    result.whenOrNull(
      requiresOtp: (purpose) => emit(const ForgotPasswordState.requiresOtp()),
    );
  }

  void _handleRequestFailure(ApiError error) {
    emit(ForgotPasswordState.error(error));
  }
}
