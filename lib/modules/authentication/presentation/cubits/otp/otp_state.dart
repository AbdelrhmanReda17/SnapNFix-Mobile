part of 'otp_cubit.dart';

@freezed
class OtpState with _$OtpState {
  const factory OtpState.initial({
    @Default(false) bool canResend,
    @Default(60) int remainingTime,
    @Default(1) int registrationExpiryTime,
  }) = _Initial;
  const factory OtpState.loading() = _Loading;
  const factory OtpState.success() = _Success;
  const factory OtpState.resendSuccess() = _ResendSuccess;
  const factory OtpState.requiresPasswordReset() = _RequiresPasswordReset;
  const factory OtpState.error(ApiErrorModel error) = _Error;
  const factory OtpState.expired() = _Expired;
  const factory OtpState.registrationExpired() = _RegistrationExpired;
}
