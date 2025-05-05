import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/verify_otp_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/resend_otp_use_case.dart';
import 'dart:async';

part 'otp_state.dart';
part 'otp_cubit.freezed.dart';

class OtpCubit extends Cubit<OtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;
  Timer? _resendTimer;
  Timer? _registrationTimer;

  static const int _resendTimeout = 10; // 1 minute for resend timeout
  static const int _registrationTimeout = 600; // 5 minutes for registration

  int _remainingResendTime = _resendTimeout;
  int _remainingRegistrationTime = _registrationTimeout;
  bool _canResend = false;

  final formKey = GlobalKey<FormState>();
  String otpCode = "";

  // Add getters for the footer
  int get remainingTime => _remainingResendTime;
  bool get canResend => _canResend;
  int get registrationTime => _remainingRegistrationTime;

  OtpCubit({required this.verifyOtpUseCase, required this.resendOtpUseCase})
    : super(const OtpState.initial()) {
    _startTimers();
  }

  void _startTimers() {
    _startResendTimer();
    _startRegistrationTimer();
  }

  void _startResendTimer() {
    _remainingResendTime = _resendTimeout;
    _canResend = false;

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingResendTime--;

      if (_remainingResendTime <= 0) {
        timer.cancel();
        _canResend = true;
        emit(
          OtpState.initial(
            canResend: true,
            remainingTime: 0,
            registrationExpiryTime: _remainingRegistrationTime,
          ),
        );
      } else {
        emit(
          OtpState.initial(
            canResend: false,
            remainingTime: _remainingResendTime,
            registrationExpiryTime: _remainingRegistrationTime,
          ),
        );
      }
    });
  }

  void _startRegistrationTimer() {
    _remainingRegistrationTime = _registrationTimeout;

    _registrationTimer?.cancel();
    _registrationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingRegistrationTime--;

      if (_remainingRegistrationTime <= 0) {
        timer.cancel();
        emit(const OtpState.registrationExpired());
        _cleanupTimers();
      } else if (_remainingRegistrationTime == 120) {
        emit(
          OtpState.initial(
            canResend: _canResend,
            remainingTime: _remainingResendTime,
            registrationExpiryTime: _remainingRegistrationTime,
          ),
        );
      } else {
        emit(
          OtpState.initial(
            canResend: _canResend,
            remainingTime: _remainingResendTime,
            registrationExpiryTime: _remainingRegistrationTime,
          ),
        );
      }
    });
  }

  Future<void> verifyOtp({
    required OtpPurpose purpose,
    String? phoneNumber,
    String? password,
  }) async {
    debugPrint("Verifying OTP: $otpCode, Purpose: $purpose");
    debugPrint("Phone Number: $phoneNumber, Password: $password");
    if (otpCode.length < 6) return;

    if (_remainingRegistrationTime <= 0) {
      emit(const OtpState.registrationExpired());
      _cleanupTimers();
      return;
    }

    emit(const OtpState.loading());
    final response = await verifyOtpUseCase.call(
      code: otpCode,
      purpose: purpose,
    );

    response.when(
      success: (res) {
        res.whenOrNull(
          requiresProfileCompletion: () {
            _cleanupTimers();
            debugPrint("Requires Profile Completion: $phoneNumber, $password");
            emit(
              OtpState.successAndRequiresProfileCompletion(
                phoneNumber: phoneNumber!,
                password: password!,
              ),
            );
          },
          requiresResetPassword: () {
            _cleanupTimers();
            emit(const OtpState.successAndRequiresPasswordReset());
          },
        );
      },
      failure: (error) {
        emit(OtpState.error(error));
        emit(
          OtpState.initial(
            canResend: _canResend,
            remainingTime: _remainingResendTime,
            registrationExpiryTime: _remainingRegistrationTime,
          ),
        );
      },
    );
  }

  void _cleanupTimers() {
    _resendTimer?.cancel();
    _registrationTimer?.cancel();
    _resendTimer = null;
    _registrationTimer = null;
  }

  @override
  Future<void> close() {
    _cleanupTimers();
    return super.close();
  }

  void updateOtpCode(
    String code,
    OtpPurpose purpose, {
    String? phoneNumber,
    String? password,
  }) {
    otpCode = code;
    if (code.length == 6) {
      verifyOtp(purpose: purpose, phoneNumber: phoneNumber, password: password);
    }
  }

  Future<void> resendOtp({required OtpPurpose purpose}) async {
    if (!_canResend) return;

    emit(const OtpState.loading());
    final response = await resendOtpUseCase.call(purpose: purpose);

    response.when(
      success: (_) {
        emit(const OtpState.resendSuccess());
        _startResendTimer();
      },
      failure: (error) {
        emit(OtpState.error(error));
        _startResendTimer();
      },
    );
  }
}
