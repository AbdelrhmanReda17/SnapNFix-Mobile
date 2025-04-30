import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/forgot_password_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/login_use_case.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginCubit({
    required LoginUseCase loginUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
  }) : _forgotPasswordUseCase = forgotPasswordUseCase,
       _loginUseCase = loginUseCase,
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
      success: (authenticationResult) async {
        authenticationResult.when(
          authenticated: (session) async {
            emit(LoginState.authenticated(session));
          },
          requiresOtp: (phoneNumber, otpToken, purpose) {
            emit(
              LoginState.requiresOtp(
                phoneNumber: phoneNumber,
                verificationToken: otpToken,
              ),
            );
          },
          unverified: (phoneNumber) async {
            emit(LoginState.unauthenticated(phoneNumber));
            _forgotPasswordUseCase.call(emailOrPhoneNumber: phoneNumber).then(
              (result) => result.when(
                success: (authResult) {
                  authResult.whenOrNull(
                    requiresOtp: (phone, token, purpose) {
                      emit(LoginState.requiresOtp(
                        phoneNumber: phone,
                        verificationToken: token,
                      ));
                    },
                  );
                },
                failure: (error) => emit(LoginState.error(error)),
              ),
            );
          },
        );
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
