part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.authenticated(Session data) = _Authenticated;
  const factory LoginState.requiresProfileCompletion() = _RequiresOtp;
  const factory LoginState.error(ApiError error) = _Error;
}
