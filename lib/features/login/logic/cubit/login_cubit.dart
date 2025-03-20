import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/helpers/constants.dart';
import 'package:snapnfix/core/networking/dio_factory.dart';
import 'package:snapnfix/features/login/data/models/login_dto.dart';
import 'package:snapnfix/features/login/data/repository/login_repository.dart';
import 'package:snapnfix/core/helpers/shared_pref_helper.dart';

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
        await saveUserToken(loginResponse.userData?.token??'');
        emit(LoginState.success(loginResponse));
      },
      failure: (error) {
        emit(LoginState.error(error: error));
      },
    );
  }
Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }
}
