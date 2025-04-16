import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/application_configurations.dart';
import 'package:snapnfix/core/helpers/shared_pref_helper.dart';
import 'package:snapnfix/features/authentication/data/models/login_dto.dart';
import 'package:snapnfix/features/authentication/data/repository/login_repository.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginRepository) : super(LoginState.initial());
  final LoginRepository _loginRepository;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(const LoginState.loading());
    final response = await _loginRepository.login(
      LoginDTO(email: emailController.text, password: passwordController.text),
    );
    response.when(
      success: (loginResponse) async {
        emit(LoginState.success(loginResponse));
        ApplicationConfigurations.instance.setUserToken(loginResponse.token);
      },
      failure: (error) {
        emit(LoginState.error(error: error));
      },
    );
  }
}
