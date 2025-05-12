part of 'otp_cubit.dart';

@freezed
class OtpState with _$OtpState {
  const factory OtpState.initial({
    @Default(false) bool canResend,
    @Default(10) int remainingTime,
    @Default(20) int registrationExpiryTime,
  }) = _Initial;
  const factory OtpState.loading() = _Loading;
  const factory OtpState.resendSuccess() = _ResendSuccess;
  const factory OtpState.successAndRequiresPasswordReset() =
      _RequiresPasswordReset;
  const factory OtpState.successAndRequiresProfileCompletion({
    required String phoneNumber,
    required String password,
  }) = _RequiresProfileCompletion;
  const factory OtpState.error(ApiErrorModel error) = _Error;
  const factory OtpState.registrationExpired() = _RegistrationExpired;
}
