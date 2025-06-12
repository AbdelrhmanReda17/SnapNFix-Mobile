part of 'forgot_password_cubit.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = _Initial;
  const factory ForgotPasswordState.loading() = _Loading;
  const factory ForgotPasswordState.requiresOtp() = _RequiresOtp;
  const factory ForgotPasswordState.error(ApiError error) = _Error;
}
