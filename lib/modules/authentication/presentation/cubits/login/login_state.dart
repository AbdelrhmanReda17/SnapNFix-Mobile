part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial({
    @Default(false) bool passwordVisible,
  }) = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(Session data) = _Success;
  const factory LoginState.requiresVerification() = _RequiresVerification;
  const factory LoginState.requiresProfile() = _RequiresProfile;
  const factory LoginState.error(ApiErrorModel error) = _Error;
}
