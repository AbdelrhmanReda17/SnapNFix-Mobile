import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/settings/domain/usecases/change_password_use_case.dart';
import 'package:snapnfix/modules/settings/domain/usecases/edit_profile_use_case.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/change_password_cubit.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/edit_profile_cubit.dart';

@module
abstract class SettingsPresentationModule {
  @factoryMethod
  ChangePasswordCubit provideChangePasswordCubit(
    ChangePasswordUseCase changePasswordUseCase,
  ) => ChangePasswordCubit(changePasswordUseCase: changePasswordUseCase);

  @factoryMethod
  EditProfileCubit provideEditProfileCubit(
    EditProfileUseCase editProfileUseCase,
  ) => EditProfileCubit(editProfileUseCase: editProfileUseCase);
}
