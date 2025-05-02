import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user_gender.dart';
import 'package:snapnfix/modules/settings/data/models/dtos/edit_profile_dto.dart';
import 'package:snapnfix/modules/settings/domain/usecases/edit_profile_use_case.dart';
part 'edit_profile_state.dart';
part 'edit_profile_cubit.freezed.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase _editProfileUseCase;

  EditProfileCubit({required EditProfileUseCase editProfileUseCase})
    : _editProfileUseCase = editProfileUseCase,
      super(const EditProfileState.initial());

  final formKey = GlobalKey<FormState>();

  String name = "";
  String phoneNumber = "";
  UserGender? selectedGender;
  DateTime? selectedDate;
  final profileImage = ValueNotifier<File?>(null);

  final _imagePicker = ImagePicker();

  void setName(String value) {
    name = value;
  }

  void setPhoneNumber(String value) {
    phoneNumber = value;
  }

  void setSelectedGender(UserGender? value) {
    selectedGender = value;
  }

  void setDateOfBirth(DateTime? value) {
    selectedDate = value;
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      }
    } catch (e) {
      emit(
        EditProfileState.error(error: 'Failed to pick image: ${e.toString()}'),
      );
    }
  }

  void emitEditProfile() async {
    if (!formKey.currentState!.validate()) return;

    emit(const EditProfileState.loading());

    try {
      final response = await _editProfileUseCase(
        EditProfileDTO(
          name: name,
          phoneNumber: phoneNumber,
          gender: selectedGender?.displayName,
          dateOfBirth: selectedDate,
          profileImage: profileImage.value,
        ),
      );

      response.when(
        success: (data) => emit(EditProfileState.success(data)),
        failure:
            (error) => emit(EditProfileState.error(error: error.toString())),
      );
    } catch (e) {
      emit(EditProfileState.error(error: e.toString()));
    }
  }
}
