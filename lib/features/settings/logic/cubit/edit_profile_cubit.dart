import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapnfix/features/authentication/data/models/user.dart';
import 'package:snapnfix/features/settings/data/models/edit_profile_dto.dart';
import 'package:snapnfix/features/settings/data/repository/edit_profile_repository.dart';

part 'edit_profile_state.dart';
part 'edit_profile_cubit.freezed.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileRepository _editProfileRepository;

  EditProfileCubit(this._editProfileRepository)
    : super(const EditProfileState.initial());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: '');
  final phoneController = TextEditingController(text: '');
  final ValueNotifier<String?> selectedGender = ValueNotifier<String?>(null);
  final ValueNotifier<DateTime?> selectedDate = ValueNotifier<DateTime?>(null);
  final ValueNotifier<File?> profileImage = ValueNotifier<File?>(null);

  // TODO: Uncomment and implement this method when the User model is available
  // void setInitialValues({required User user}) {
  //   nameController.text = user.name;
  //   phoneController.text = user.phoneNumber;
  //   selectedGender.value = null;
  //   selectedDate.value = null;
  //   profileImage.value = File(user.profileImage ?? '');
  // }

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
