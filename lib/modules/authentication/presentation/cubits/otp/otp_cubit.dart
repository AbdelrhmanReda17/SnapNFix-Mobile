import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/verify_otp_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/resend_otp_use_case.dart';

part 'otp_state.dart';
part 'otp_cubit.freezed.dart';

class OtpCubit extends Cubit<OtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;
  
  OtpCubit({
    required this.verifyOtpUseCase,
    required this.resendOtpUseCase,
  }) : super(const OtpState.initial());

  String otpCode = "";
  final formKey = GlobalKey<FormState>();

  void updateOtpCode(String code) {
    otpCode += code; // make sure
  }

  Future<void> verifyOtp({bool isFormForgotPassword = false}) async {
    if (otpCode.length < 6) {
      return;
    }

    emit(const OtpState.loading());
    final response = await verifyOtpUseCase.call(
      code: otpCode,
    );
    
    response.when(
      success: (session) async {
        emit(OtpState.success(
          session, 
          isFormForgotPassword: isFormForgotPassword
        ));
      },
      failure: (ApiErrorModel error) {
        emit(OtpState.error(error));
      },
    );
  }

  Future<void> resendOtp() async {
    emit(const OtpState.loading());
    final response = await resendOtpUseCase.call();
    
    response.when(
      success: (_) async {
        emit(OtpState.resendSuccess());
      },
      failure: (ApiErrorModel error) {
        emit(OtpState.error(error));
      },
    );
  }
}