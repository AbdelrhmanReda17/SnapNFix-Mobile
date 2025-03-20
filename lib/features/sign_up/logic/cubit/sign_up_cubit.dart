import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/features/sign_up/data/models/sign_up_dto.dart';
import 'package:snapnfix/features/sign_up/data/repository/sign_up_repository.dart';

part 'sign_up_state.dart';
part 'sign_up_cubit.freezed.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signUpRepository) : super(SignUpState.initial());
  final SignUpRepository _signUpRepository;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void emitSignUpStates() async {
    emit(const SignUpState.loading());
    final response = await _signUpRepository.signup(
      SignUpDTO(
          phone: phoneController.text,
          password: passwordController.text,
          passwordConfirmation: passwordConfirmationController.text
      ),
    );
    response.when(
        success: (signUpResponse) async {
          emit(SignUpState.success(signUpResponse));
        },
        failure: (error) {
          emit(SignUpState.error(error: error));
        }
    );
  }

}