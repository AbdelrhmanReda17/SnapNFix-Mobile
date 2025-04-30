part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial({@Default(false) bool passwordVisible}) =
      _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.authenticated(Session data) = _Authenticated;
  const factory LoginState.unauthenticated(String phoneNumber) =
      _Unauthenticated;
  const factory LoginState.requiresOtp({
    required String phoneNumber,
    required String verificationToken,
  }) = _RequiresOtp;
  const factory LoginState.error(ApiErrorModel error) = _Error;
}
