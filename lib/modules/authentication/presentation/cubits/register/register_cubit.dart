import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/request_otp_use_case.dart';

part 'register_state.dart';
part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RequestOTPUseCase _requestOTPUseCase;
  final formKey = GlobalKey<FormState>();

  String _phone = "";
  String _password = "";
  String _confirmPassword = "";

  String get phone => _phone;
  String get password => _password;
  String get confirmPassword => _confirmPassword;

  RegisterCubit(this._requestOTPUseCase) : super(const RegisterState.initial());

  void setPhone(String value) {
    _phone = value.trim();
  }

  void setPassword(String value) {
    _password = value;
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
  }

  void reset() {
    _phone = "";
    _password = "";
    _confirmPassword = "";
    emit(const RegisterState.initial());
  }

  @override
  Future<void> close() {
    reset();
    return super.close();
  }

  Future<void> register() async {
    if (!_validateForm()) return;

    try {
      emit(const RegisterState.loading());

      final response = await _requestOTPUseCase.call(
        phoneNumber: _phone,
        purpose: OtpPurpose.registration,
      );

      if (isClosed) return;

      response.when(
        success: _handleRegistrationSuccess,
        failure: _handleRegistrationFailure,
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        RegisterState.error(
          ApiErrorModel(message: 'An unexpected error occurred'),
        ),
      );
    }
  }

  bool _validateForm() {
    if (!formKey.currentState!.validate()) {
      emit(
        RegisterState.error(
          ApiErrorModel(message: 'Please fill in all required fields'),
        ),
      );
      return false;
    }

    if (_password != _confirmPassword) {
      emit(
        RegisterState.error(ApiErrorModel(message: 'Passwords do not match')),
      );
      return false;
    }

    return true;
  }

  void _handleRegistrationSuccess(AuthenticationResult result) {
    result.whenOrNull(
      requiresOtp: (purpose) => emit(const RegisterState.requiresOtp()),
    );
  }

  void _handleRegistrationFailure(ApiErrorModel error) {
    emit(RegisterState.error(error));
  }
}
