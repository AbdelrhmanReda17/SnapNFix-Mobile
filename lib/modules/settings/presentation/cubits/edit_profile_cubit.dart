import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final selectedGender = ValueNotifier<String?>(null);
  final selectedDate = ValueNotifier<DateTime?>(null);
  final profileImage = ValueNotifier<File?>(null);

  final _imagePicker = ImagePicker();

  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  void updateGender(String gender) {
    selectedGender.value = gender;
  }

  void updateDate(DateTime date) {
    selectedDate.value = date;
  }

  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
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
          name: nameController.text,
          phoneNumber: phoneController.text,
          gender: selectedGender.value ?? '',
          dateOfBirth: selectedDate.value,
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

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    selectedGender.dispose();
    selectedDate.dispose();
    profileImage.dispose();
    return super.close();
  }
}
