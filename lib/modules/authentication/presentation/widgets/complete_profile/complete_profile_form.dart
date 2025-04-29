import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_date_picker_field.dart';
import 'package:snapnfix/core/base_components/base_dropdrown_field.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/core/utils/extensions/validations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user_gender.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/complete_profile/complete_profile_cubit.dart';

class CompleteProfileForm extends StatelessWidget {
  const CompleteProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Form(
      key: context.read<CompleteProfileCubit>().formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Column(
          children: [
            BaseTextField(
              hintText: localizations.firstName,
              controller:
                  context.read<CompleteProfileCubit>().firstNameController,
              validator:
                  (value) =>
                      value!.isNotEmpty
                          ? value.isValidFirstName
                              ? null
                              : localizations.firstNameError
                          : localizations.firstNameRequired,
            ),
            verticalSpace(16),
            BaseTextField(
              hintText: localizations.lastName,
              controller:
                  context.read<CompleteProfileCubit>().lastNameController,
              validator:
                  (value) =>
                      value!.isNotEmpty
                          ? value.isValidLastName
                              ? null
                              : localizations.lastNameError
                          : localizations.lastNameRequired,
            ),
            verticalSpace(16),
            BlocSelector<
              CompleteProfileCubit,
              CompleteProfileState,
              UserGender
            >(
              selector:
                  (state) => state.maybeWhen(
                    initial: (gender, _) => gender,
                    orElse: () => UserGender.notSpecified,
                  ),
              builder: (context, selectedGender) {
                return BaseDropdownField<UserGender>(
                  hintText: localizations.gender,
                  value: selectedGender,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<CompleteProfileCubit>().updateGender(value);
                    }
                  },
                  itemLabelBuilder: (item) => item.displayName,
                  items: UserGender.values,
                );
              },
            ),

            verticalSpace(16),
            BlocSelector<CompleteProfileCubit, CompleteProfileState, DateTime?>(
              selector:
                  (state) => state.maybeWhen(
                    initial: (_, dateOfBirth) => dateOfBirth,
                    orElse: () => null,
                  ),
              builder: (context, selectedDate) {
                return BaseDatePickerField(
                  hintText: localizations.dateOfBirth,
                  value: selectedDate,
                  onTap: () async {
                    final pickedDate =
                        await BaseDatePickerField.showCustomDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                    if (pickedDate != null) {
                      context.read<CompleteProfileCubit>().updateDateOfBirth(
                        pickedDate,
                      );
                    }
                  },
                  dateFormatter:
                      context.read<CompleteProfileCubit>().formatDate,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
