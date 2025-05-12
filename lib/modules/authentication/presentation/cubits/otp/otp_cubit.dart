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
  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResendOtpUseCase _resendOtpUseCase;

  Timer? _resendTimer;
  Timer? _registrationTimer;

  static const int _resendTimeout = 10; // 1 minute for resend timeout
  static const int _registrationTimeout = 600; // 5 minutes for registration

  int _remainingResendTime = _resendTimeout;
  int _remainingRegistrationTime = _registrationTimeout;
  bool _canResend = false;

  final formKey = GlobalKey<FormState>();
  String _otpCode = "";

  int get remainingTime => _remainingResendTime;
  bool get canResend => _canResend;
  int get registrationTime => _remainingRegistrationTime;

  OtpCubit({
    required VerifyOtpUseCase verifyOtpUseCase,
    required ResendOtpUseCase resendOtpUseCase,
  }) : _verifyOtpUseCase = verifyOtpUseCase,
       _resendOtpUseCase = resendOtpUseCase,
       super(const OtpState.initial()) {
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
        _emitInitialState();
      } else {
        _emitInitialState();
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
        _emitInitialState();
      } else {
        _emitInitialState();
      }
    });
  }

  void _emitInitialState() {
    emit(
      OtpState.initial(
        canResend: _canResend,
        remainingTime: _remainingResendTime,
        registrationExpiryTime: _remainingRegistrationTime,
      ),
    );
  }

  Future<void> verifyOtp({
    required OtpPurpose purpose,
    String? phoneNumber,
    String? password,
  }) async {
    if (!_validateOtp()) return;

    try {
      emit(const OtpState.loading());

      final response = await _verifyOtpUseCase.call(
        code: _otpCode,
        purpose: purpose,
      );

      response.when(
        success:
            (result) => _handleVerificationSuccess(
              result,
              phoneNumber: phoneNumber,
              password: password,
            ),
        failure: (error) => _handleVerificationFailure(error),
      );
    } catch (e) {
      _handleVerificationFailure(
        ApiErrorModel(message: 'An unexpected error occurred'),
      );
    }
  }

  bool _validateOtp() {
    if (_otpCode.length < 6) {
      emit(
        OtpState.error(ApiErrorModel(message: 'Please enter a valid OTP code')),
      );
      return false;
    }

    if (_remainingRegistrationTime <= 0) {
      emit(const OtpState.registrationExpired());
      _cleanupTimers();
      return false;
    }

    return true;
  }

  void _handleVerificationSuccess(
    AuthenticationResult result, {
    String? phoneNumber,
    String? password,
  }) {
    result.whenOrNull(
      requiresProfileCompletion: () {
        _cleanupTimers();
        if (phoneNumber == null || password == null) {
          emit(
            OtpState.error(
              ApiErrorModel(message: 'Missing required parameters'),
            ),
          );
          return;
        }
        emit(
          OtpState.successAndRequiresProfileCompletion(
            phoneNumber: phoneNumber,
            password: password,
          ),
        );
      },
      requiresResetPassword: () {
        _cleanupTimers();
        emit(const OtpState.successAndRequiresPasswordReset());
      },
    );
  }

  void _handleVerificationFailure(ApiErrorModel error) {
    emit(OtpState.error(error));
    _emitInitialState();
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

  Future<void> updateOtpCode(
    String code,
    OtpPurpose purpose, {
    String? phoneNumber,
    String? password,
  }) async {
    _otpCode = code;
    if (code.length == 6) {
      await verifyOtp(
        purpose: purpose,
        phoneNumber: phoneNumber,
        password: password,
      );
    }
  }

  Future<void> resendOtp({required OtpPurpose purpose}) async {
    if (!_canResend) return;

    try {
      emit(const OtpState.loading());

      final response = await _resendOtpUseCase.call(purpose: purpose);

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
    } catch (e) {
      emit(
        OtpState.error(
          ApiErrorModel(
            message: 'An unexpected error occurred while resending OTP',
          ),
        ),
      );
      _startResendTimer();
    }
  }
}
