import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user_gender.dart';
import 'package:snapnfix/modules/settings/data/models/dtos/edit_profile_dto.dart';
import 'package:snapnfix/modules/settings/domain/usecases/edit_profile_use_case.dart';
part 'edit_profile_state.dart';
part 'edit_profile_cubit.freezed.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase _editProfileUseCase;
  final User _currentUser;

  EditProfileCubit({required EditProfileUseCase editProfileUseCase})
    : _editProfileUseCase = editProfileUseCase,
      _currentUser = getIt<ApplicationConfigurations>().currentSession!.user,
      super(const EditProfileState.initial()) {
    initializeUserData();
  }

  final formKey = GlobalKey<FormState>();

  String name = "";
  String phoneNumber = "";
  UserGender? selectedGender;
  DateTime? selectedDate;
  final profileImage = ValueNotifier<File?>(null);

  bool _valuesModified = false;
  final resetCounter = ValueNotifier<int>(0);

  final _imagePicker = ImagePicker();

  void initializeUserData() {
    name = "${_currentUser.firstName} ${_currentUser.lastName}";
    phoneNumber = _currentUser.phoneNumber;
    selectedGender = _currentUser.gender;
    selectedDate = _currentUser.dateOfBirth;
    profileImage.value =
        _currentUser.profileImage != null
            ? File(_currentUser.profileImage!)
            : null;

    _valuesModified = false;
    resetCounter.value += 1;
  }

  void setName(String value) {
    name = value;
    _valuesModified = true;
  }

  void setPhoneNumber(String value) {
    phoneNumber = value;
  }

  void setSelectedGender(UserGender? value) {
    selectedGender = value;
    _valuesModified = true;
  }

  void setDateOfBirth(DateTime? value) {
    selectedDate = value;
    _valuesModified = true;
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

  String? get userProfileImage => _currentUser.profileImage;
  bool get hasBeenModified => _valuesModified;
}
