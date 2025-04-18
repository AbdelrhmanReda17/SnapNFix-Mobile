import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapnfix/features/settings/data/models/edit_profile_dto.dart';
import 'package:snapnfix/features/settings/data/repos/edit_profile_repository.dart';

part 'edit_profile_state.dart';
part 'edit_profile_cubit.freezed.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileRepository _editProfileRepository;

  EditProfileCubit(this._editProfileRepository)
    : super(const EditProfileState.initial());

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController(text: 'Amr Ahmed Mohammed');
  final phoneController = TextEditingController(text: '01246579634');

  final ValueNotifier<String> selectedGender = ValueNotifier<String>('Male');
  final ValueNotifier<DateTime> selectedDate = ValueNotifier<DateTime>(
    DateTime(1977, 4, 10),
  );
  final ValueNotifier<File?> profileImage = ValueNotifier<File?>(null);

  final List<String> genderOptions = ['Male', 'Female', 'Prefer not to say'];

  void updateGender(String gender) {
    selectedGender.value = gender;
  }

  void updateDate(DateTime date) {
    selectedDate.value = date;
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      profileImage.value = File(image.path);
    }
  }

  void resetForm() {
    nameController.text = 'Amr Ahmed Mohammed';
    phoneController.text = '01246579634';
    selectedGender.value = 'Male';
    selectedDate.value = DateTime(1977, 4, 10);
    profileImage.value = null;
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void emitEditProfile() async {
    emit(const EditProfileState.loading());

    final result = await _editProfileRepository.editProfile(
      EditProfileDTO(
        name: nameController.text,
        phoneNumber: phoneController.text,
        gender: selectedGender.value,
        dateOfBirth: selectedDate.value,
        profileImage: profileImage.value,
      ),
    );

    result.when(
      success: (data) => emit(EditProfileState.success(data)),
      failure: (error) => emit(EditProfileState.error(error: error)),
    );
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
