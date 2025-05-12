import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';

part 'authentication_result.freezed.dart';

@freezed
class AuthenticationResult with _$AuthenticationResult {
  const factory AuthenticationResult.authenticated(Session session) =
      Authenticated;
  const factory AuthenticationResult.requiresOtp({
    required OtpPurpose purpose,
  }) = RequiresOtp;
  const factory AuthenticationResult.requiresProfileCompletion(
  ) = RequiresProfileCompletion;

  const factory AuthenticationResult.requiresResetPassword(
  ) = RequiresResetPassword;
}

enum OtpPurpose { registration, passwordReset }
