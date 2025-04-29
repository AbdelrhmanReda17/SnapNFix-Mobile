part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial({
    @Default(false) bool passwordVisible,
    @Default(false) bool confirmPasswordVisible,
  }) = _Initial;
  const factory RegisterState.loading() = _Loading;
  const factory RegisterState.success(Session session) = _Success;
  const factory RegisterState.requiresVerification() = _RequiresVerification;
  const factory RegisterState.requiresProfile() = _RequiresProfile;
  const factory RegisterState.error(ApiErrorModel error) = _Error;
}
