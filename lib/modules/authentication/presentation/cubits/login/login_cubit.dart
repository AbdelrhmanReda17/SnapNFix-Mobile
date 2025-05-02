import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/login_use_case.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final formKey = GlobalKey<FormState>();

  String emailOrPhone = "";
  String password = "";

  LoginCubit({required LoginUseCase loginUseCase})
    : _loginUseCase = loginUseCase,
      super(const LoginState.initial());

  void setEmailOrPhone(String value) {
    emailOrPhone = value;
  }

  void setPassword(String value) {
    password = value;
  }

  void emitLoginStates() async {
    if (!formKey.currentState!.validate()) return;

    emit(const LoginState.loading());
    final response = await _loginUseCase.call(
      phoneOrEmail: emailOrPhone,
      password: password,
    );

    response.when(
      success: (authenticationResult) async {
        authenticationResult.whenOrNull(
          authenticated: (session) async {
            emit(LoginState.authenticated(session));
          },
          requiresProfileCompletion: () {
            emit(LoginState.requiresProfileCompletion());
          },
        );
      },
      failure: (error) => emit(LoginState.error(error)),
    );
  }
}
