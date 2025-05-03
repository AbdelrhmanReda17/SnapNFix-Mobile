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
    _phone = value;
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

  Future<void> emitRegisterStates() async {
    if (!formKey.currentState!.validate()) return;

    emit(const RegisterState.loading());

    final response = await _requestOTPUseCase.call(
      phoneNumber: _phone,
      purpose: OtpPurpose.registration,
    );

    if (isClosed) return; // Check if cubit is still active

    response.when(
      success: (authResult) {
        authResult.whenOrNull(
          requiresOtp: (purpose) => emit(const RegisterState.requiresOtp()),
        );
      },
      failure: (error) => emit(RegisterState.error(error)),
    );
  }
}
