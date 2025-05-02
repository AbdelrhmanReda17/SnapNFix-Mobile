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
  static const int _resendTimeout = 10; // 2 minutes
  static const int _registrationTimeout = 300; // 5 minutes

  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;
  Timer? _resendTimer;
  Timer? _registrationTimer;

  final formKey = GlobalKey<FormState>();
  String otpCode = "";

  OtpCubit({required this.verifyOtpUseCase, required this.resendOtpUseCase})
    : super(const OtpState.initial()) {
    _startTimers();
  }

  void _startTimers() {
    _startResendTimer();
    _startRegistrationTimer();
  }

  void _startResendTimer() {
    int timeLeft = _resendTimeout;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeLeft--;
      if (timeLeft <= 0) {
        timer.cancel();
        emit(
          state.maybeMap(
            initial:
                (s) => OtpState.initial(
                  canResend: true,
                  remainingTime: 0,
                  registrationExpiryTime: s.registrationExpiryTime,
                ),
            orElse: () => const OtpState.initial(canResend: true),
          ),
        );
      } else {
        emit(
          OtpState.initial(
            canResend: false,
            remainingTime: timeLeft,
            registrationExpiryTime: state.maybeMap(
              initial: (s) => s.registrationExpiryTime,
              orElse: () => _registrationTimeout,
            ),
          ),
        );
      }
    });
  }

  void _startRegistrationTimer() {
    int timeLeft = _registrationTimeout;
    _registrationTimer?.cancel();
    _registrationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeLeft--;
      if (timeLeft <= 0) {
        timer.cancel();
        emit(const OtpState.registrationExpired());
      } else {
        emit(
          OtpState.initial(
            canResend: state.maybeMap(
              initial: (s) => s.canResend,
              orElse: () => false,
            ),
            remainingTime: state.maybeMap(
              initial: (s) => s.remainingTime,
              orElse: () => _resendTimeout,
            ),
            registrationExpiryTime: timeLeft,
          ),
        );
      }
    });
  }

  Future<void> verifyOtp({
    required OtpPurpose purpose,
    String? phoneNumber,
    String? password,
    bool isRegister = false,
  }) async {
    if (otpCode.length < 6) return;

    if (state.maybeMap(
      initial: (s) => s.registrationExpiryTime <= 0,
      orElse: () => false,
    )) {
      emit(const OtpState.registrationExpired());
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
            emit(
              OtpState.successAndRequiresProfileCompletion(
                phoneNumber: phoneNumber!,
                password: password!,
              ),
            );
          },
          requiresResetPassword: () {
            emit(const OtpState.successAndRequiresPasswordReset());
          },
        );
        _cleanupTimers();
      },
      failure: (error) => emit(OtpState.error(error)),
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

  void reset() {
    _cleanupTimers();
    otpCode = "";
    emit(const OtpState.initial());
  }

  void updateOtpCode(String code, OtpPurpose purpose) {
    otpCode = code;
    if (code.length == 6) {
      verifyOtp(purpose: purpose);
    }
  }

  Future<void> resendOtp({bool isRegister = false}) async {
    if (!state.maybeMap(initial: (s) => s.canResend, orElse: () => false)) {
      return;
    }

    emit(const OtpState.loading());
    final response = await resendOtpUseCase.call(isRegister: isRegister);

    response.when(
      success: (_) {
        emit(const OtpState.resendSuccess());
        _startResendTimer();
      },
      failure: (error) => emit(OtpState.error(error)),
    );
  }
}
