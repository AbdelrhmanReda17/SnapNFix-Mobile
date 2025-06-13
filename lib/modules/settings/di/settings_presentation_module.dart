import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/settings/domain/usecases/edit_profile_use_case.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/edit_profile_cubit.dart';

@module
abstract class SettingsPresentationModule {
  @factoryMethod
  EditProfileCubit provideEditProfileCubit(
    EditProfileUseCase editProfileUseCase,
  ) => EditProfileCubit(editProfileUseCase: editProfileUseCase);
}
