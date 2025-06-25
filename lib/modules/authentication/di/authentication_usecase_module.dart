import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/register_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/login_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/logout_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/request_otp_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/resend_otp_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/reset_password_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/social_sign_in_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/verify_otp_use_case.dart';

@module
abstract class AuthenticationUseCaseModule {
  @injectable
  LoginUseCase provideLoginUseCase(BaseAuthenticationRepository repository) =>
      LoginUseCase(repository);

  @injectable
  RequestOTPUseCase provideRequestOTPUseCase(
    BaseAuthenticationRepository repository,
  ) => RequestOTPUseCase(repository);

  @injectable
  VerifyOtpUseCase provideVerifyOtpUseCase(
    BaseAuthenticationRepository repository,
  ) => VerifyOtpUseCase(repository);

  @injectable
  ResendOtpUseCase provideResendOtpUseCase(
    BaseAuthenticationRepository repository,
  ) => ResendOtpUseCase(repository);

  @injectable
  ResetPasswordUseCase provideResetPasswordUseCase(
    BaseAuthenticationRepository repository,
  ) => ResetPasswordUseCase(repository);

  @injectable
  CompleteProfileUseCase provideCompleteProfileUseCase(
    BaseAuthenticationRepository repository,
  ) => CompleteProfileUseCase(repository);

  @injectable
  SocialSignInUseCase provideSocialSignInUseCase(
    BaseAuthenticationRepository repository,
  ) => SocialSignInUseCase(repository);

  @injectable
  LogoutUseCase provideLogoutUseCase(BaseAuthenticationRepository repository) =>
      LogoutUseCase(repository);
}
