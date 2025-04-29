import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/verify_otp_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/resend_otp_use_case.dart';

part 'otp_state.dart';
part 'otp_cubit.freezed.dart';

class OtpCubit extends Cubit<OtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;

  final formKey = GlobalKey<FormState>();
  String otpCode = "";

  OtpCubit({required this.verifyOtpUseCase, required this.resendOtpUseCase})
    : super(const OtpState.initial());

  void updateOtpCode(String code) {
    otpCode = code;
  }

  Future<void> verifyOtp({bool isFromForgotPassword = false}) async {
    if (otpCode.length < 6) return;
    emit(const OtpState.loading());
    final response = await verifyOtpUseCase.call(code: otpCode);
    response.when(
      success: (session) {
        if (isFromForgotPassword) {
          emit(const OtpState.requiresPasswordReset());
        } else if (!session.user.isProfileComplete) {
          emit(const OtpState.requiresProfile());
        } else {
          emit(OtpState.success(session));
        }
      },
      failure: (error) => emit(OtpState.error(error)),
    );
  }

  Future<void> resendOtp() async {
    emit(const OtpState.loading());

    final response = await resendOtpUseCase.call();

    response.when(
      success: (_) => emit(const OtpState.resendSuccess()),
      failure: (error) => emit(OtpState.error(error)),
    );
  }
}
