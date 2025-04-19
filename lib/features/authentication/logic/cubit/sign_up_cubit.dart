 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/application_configurations.dart';
import 'package:snapnfix/features/authentication/data/models/sign_up_dto.dart';
import 'package:snapnfix/features/authentication/data/repository/sign_up_repository.dart';

part 'sign_up_state.dart';
part 'sign_up_cubit.freezed.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signUpRepository) : super(SignUpState.initial());
  final SignUpRepository _signUpRepository;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  void emitSignUpStates() async {
    emit(const SignUpState.loading());
    final response = await _signUpRepository.signUp(
      SignUpDTO(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phone: phoneController.text,
        password: passwordController.text,
        passwordConfirmation: passwordConfirmationController.text,
      ),
    );
    response.when(
      success: (signUpResponse) async {
        emit(SignUpState.success(signUpResponse));
        ApplicationConfigurations.instance.setUserToken(signUpResponse.token);
      },
      failure: (error) {
        emit(SignUpState.error(error: error));
      },
    );
  }
}
