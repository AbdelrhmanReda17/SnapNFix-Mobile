part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial({
    @Default(false) bool passwordVisible,
    @Default(false) bool confirmPasswordVisible,
  }) = _Initial;
  const factory RegisterState.loading() = _Loading;
  const factory RegisterState.requiresOtp({
    required String phoneNumber,
    required String verificationToken,
  }) = _RequiresOtp;
  const factory RegisterState.authenticated(Session data) = _Authenticated;
  const factory RegisterState.error(ApiErrorModel error) = _Error;
}
