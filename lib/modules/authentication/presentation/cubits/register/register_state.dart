part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = _Initial;
  const factory RegisterState.loading() = _Loading;
  const factory RegisterState.requiresOtp() = _RequiresOtp;
  const factory RegisterState.authenticated(Session data) = _Authenticated;
  const factory RegisterState.error(ApiError error) = _Error;
}
