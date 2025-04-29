part of 'otp_cubit.dart';


@freezed
class OtpState with _$OtpState {
  const factory OtpState.initial() = _Initial;
  const factory OtpState.loading() = _Loading;
  const factory OtpState.success(Session session) = _Success;
  const factory OtpState.resendSuccess() = _ResendSuccess;
  const factory OtpState.requiresProfile() = _RequiresProfile;
  const factory OtpState.requiresPasswordReset() = _RequiresPasswordReset;
  const factory OtpState.error(ApiErrorModel error) = _Error;
}
