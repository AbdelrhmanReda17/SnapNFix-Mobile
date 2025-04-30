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
    int timeLeft = 60;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeLeft--;
      if (timeLeft <= 0) {
        timer.cancel();
        emit(const OtpState.expired()); // Emit expired state instead of initial
      } else {
        emit(
          OtpState.initial(
            canResend: false,
            remainingTime: timeLeft,
            registrationExpiryTime: state.maybeMap(
              initial: (s) => s.registrationExpiryTime,
              orElse: () => 600, // 10 minutes for registration
            ),
          ),
        );
      }
    });
  }

  void _startRegistrationTimer() {
    int timeLeft = 600;
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
              orElse: () => 60,
            ),
            registrationExpiryTime: timeLeft,
          ),
        );
      }
    });
  }

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    _registrationTimer?.cancel();
    return super.close();
  }

  void updateOtpCode(String code) {
    otpCode = code;
  }

  Future<void> verifyOtp(
    String phoneNumber,
    String otpVerificationCode,
    OtpPurpose purpose,
  ) async {
    if (otpCode.length < 6) return;
    // Check if OTP is expired
    if (state.maybeMap(
      initial: (s) => s.remainingTime <= 0,
      orElse: () => false,
    )) {
      emit(const OtpState.expired());
      return;
    }

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
      verificationToken: otpVerificationCode,
      phoneNumber: phoneNumber,
    );

    response.when(
      success: (session) {
        _resendTimer?.cancel();
        _registrationTimer?.cancel();
        if (purpose == OtpPurpose.passwordReset) {
          emit(const OtpState.requiresPasswordReset());
        } else {
          emit(OtpState.success());
        }
      },
      failure: (error) => emit(OtpState.error(error)),
    );
  }

  Future<void> resendOtp() async {
    if (!state.maybeMap(initial: (s) => s.canResend, orElse: () => false))
      return;

    emit(const OtpState.loading());
    final response = await resendOtpUseCase.call();

    response.when(
      success: (_) {
        emit(const OtpState.resendSuccess());
        _startResendTimer();
      },
      failure: (error) => emit(OtpState.error(error)),
    );
  }
}
