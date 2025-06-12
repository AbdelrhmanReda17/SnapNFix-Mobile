import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/authentication/index.dart';
import 'package:snapnfix/core/index.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final SocialSignInUseCase _socialSignInUseCase;

  final formKey = GlobalKey<FormState>();

  String _emailOrPhone = "";
  String _password = "";

  LoginCubit({
    required LoginUseCase loginUseCase,
    required SocialSignInUseCase socialSignInUseCase,
  }) : _loginUseCase = loginUseCase,
       _socialSignInUseCase = socialSignInUseCase,
       super(const LoginState.initial());

  void setEmailOrPhone(String value) {
    _emailOrPhone = value.trim();
  }

  void setPassword(String value) {
    _password = value;
  }

  Future<void> login() async {
    if (!_validateForm()) return;

    try {
      emit(const LoginState.loading());

      final response = await _loginUseCase.call(
        phoneOrEmail: _emailOrPhone,
        password: _password,
      );

      response.when(success: _handleLoginSuccess, failure: _handleLoginFailure);
    } catch (e) {
      emit(LoginState.error(ApiError(message: 'An unexpected error occurred')));
    }
  }

  bool _validateForm() {
    if (!formKey.currentState!.validate()) {
      emit(
        LoginState.error(
          ApiError(message: 'Please fill in all required fields'),
        ),
      );
      return false;
    }
    return true;
  }

  void _handleLoginSuccess(AuthenticationResult result) {
    result.whenOrNull(
      authenticated: (session) => emit(LoginState.authenticated(session)),
      requiresProfileCompletion:
          () => emit(const LoginState.requiresProfileCompletion()),
    );
  }

  void _handleLoginFailure(ApiError error) {
    emit(LoginState.error(error));
  }

  Future<void> signInWithGoogle() async {
    await _socialSignIn(SocialAuthenticationProvider.google);
  }

  Future<void> signInWithFacebook() async {
    await _socialSignIn(SocialAuthenticationProvider.facebook);
  }

  Future<void> _socialSignIn(SocialAuthenticationProvider provider) async {
    try {
      emit(const LoginState.loading());

      final result =
          provider == SocialAuthenticationProvider.google
              ? await _socialSignInUseCase.callGoogleSignIn()
              : await _socialSignInUseCase.callFacebookSignIn();

      result.when(
        success: (authResult) {
          authResult.whenOrNull(
            authenticated: (session) => emit(LoginState.authenticated(session)),
            requiresProfileCompletion:
                () => emit(const LoginState.requiresProfileCompletion()),
          );
        },
        failure: (error) => emit(LoginState.error(error)),
      );
    } catch (e) {
      emit(
        LoginState.error(
          ApiError(
            message: 'An unexpected error occurred during social sign in',
          ),
        ),
      );
    }
  }
}
