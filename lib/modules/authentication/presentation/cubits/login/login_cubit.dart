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

  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginCubit({required LoginUseCase loginUseCase})
    : _loginUseCase = loginUseCase,
      super(const LoginState.initial(passwordVisible: false));

  bool get passwordVisible => state.maybeMap(
    initial: (state) => state.passwordVisible,
    orElse: () => false,
  );

  void togglePasswordVisibility() {
    state.maybeMap(
      initial: (state) {
        emit(LoginState.initial(passwordVisible: !state.passwordVisible));
      },
      orElse: () {},
    );
  }

  void emitLoginStates() async {
    if (!formKey.currentState!.validate()) return;

    emit(const LoginState.loading());
    final response = await _loginUseCase.call(
      phoneOrEmail: emailOrPhoneController.text,
      password: passwordController.text,
    );

    response.when(
      success: (session) async {
        if (!session.user.isVerified) {
          emit(const LoginState.requiresVerification());
        } else if (!session.user.isProfileComplete) {
          emit(const LoginState.requiresProfile());
        } else {
          emit(LoginState.success(session));
        }
      },
      failure: (error) => emit(LoginState.error(error)),
    );
  }

  @override
  Future<void> close() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
